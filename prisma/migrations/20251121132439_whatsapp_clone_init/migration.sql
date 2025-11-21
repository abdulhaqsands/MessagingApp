-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `isBlooked` BOOLEAN NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `message` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(191) NULL,
    `senderId` INTEGER NOT NULL,
    `receiverId` INTEGER NULL,
    `status` VARCHAR(191) NULL DEFAULT 'sent',
    `editedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(3) NULL,
    `roomId` INTEGER NULL,
    `groupId` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `message_senderId_idx`(`senderId`),
    INDEX `message_receiverId_idx`(`receiverId`),
    INDEX `message_roomId_idx`(`roomId`),
    INDEX `message_groupId_idx`(`groupId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mediaAttachment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fileUrl` VARCHAR(191) NULL,
    `messageId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `group` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `groupName` VARCHAR(191) NOT NULL,
    `createdBy` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `group_groupName_key`(`groupName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `groupMember` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `groupId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `joinedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `groupMember_groupId_userId_key`(`groupId`, `userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `room` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `isGroup` BOOLEAN NOT NULL DEFAULT false,
    `name` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `room_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roomMember` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `roomId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `joinedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `roomMember_roomId_userId_key`(`roomId`, `userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messageReadStatus` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `messageId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `isRead` BOOLEAN NOT NULL DEFAULT false,

    INDEX `messageReadStatus_userId_idx`(`userId`),
    INDEX `messageReadStatus_messageId_idx`(`messageId`),
    UNIQUE INDEX `messageReadStatus_messageId_userId_key`(`messageId`, `userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `message` ADD CONSTRAINT `message_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `message` ADD CONSTRAINT `message_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `user`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `message` ADD CONSTRAINT `message_roomId_fkey` FOREIGN KEY (`roomId`) REFERENCES `room`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `message` ADD CONSTRAINT `message_groupId_fkey` FOREIGN KEY (`groupId`) REFERENCES `group`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `mediaAttachment` ADD CONSTRAINT `mediaAttachment_messageId_fkey` FOREIGN KEY (`messageId`) REFERENCES `message`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `group` ADD CONSTRAINT `group_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `groupMember` ADD CONSTRAINT `groupMember_groupId_fkey` FOREIGN KEY (`groupId`) REFERENCES `group`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `groupMember` ADD CONSTRAINT `groupMember_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `roomMember` ADD CONSTRAINT `roomMember_roomId_fkey` FOREIGN KEY (`roomId`) REFERENCES `room`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `roomMember` ADD CONSTRAINT `roomMember_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `messageReadStatus` ADD CONSTRAINT `messageReadStatus_messageId_fkey` FOREIGN KEY (`messageId`) REFERENCES `message`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `messageReadStatus` ADD CONSTRAINT `messageReadStatus_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
