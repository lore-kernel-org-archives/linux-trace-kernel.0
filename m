Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0A21110
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppAyk+Eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17672C433C7;
	Wed,  4 Oct 2023 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445712;
	bh=XBmNDeJ7i675C+Gqvs30b2zycqgu44WCEf/N/NZrkg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppAyk+Eg4X3oYeDh4VbHhyxo0RFdxGDi/En92Iktn7jh7p9zGA8ldu+i7QC2Xhr8y
	 WrrMZgT4v+Mp2CNEcfRScrnNbpa18rPgQNGpVDosO7/R4lKeqFuvusHsYysTePlMow
	 rtga7EjrMXOlVLruaWgXs0kYFQndnHjxd/ta17NZBykqSWWMBO7pDFN483vTM8EKtr
	 Pr75rUcR44L/9FHe7HA0vUM+SDuyud6DM7Xn6rJbJInJuA1mEh+DHnG1Ct0iKo9ge/
	 HMZsp5iyhMeTHF1M7ZsfzW4SG9ovmua1ezR8QFlVYMcqpicCX3e91u+z9OGu3WkSDH
	 OD7BUldhfXz/Q==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 72/89] tracefs: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:52:57 -0400
Message-ID: <20231004185347.80880-70-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 891653ba9cf3..429603d865a9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -152,7 +152,7 @@ struct inode *tracefs_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
-- 
2.41.0

