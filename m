Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BB33A9DA;
	Thu,  7 May 2026 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141487; cv=none; b=sCLGoyFN4NsFJrcKEY2JsYDMNxxwhfkJUKUg07OW6Hd9/2RhdhRKFZKnlduGcMOfUFRI7p+dihwvF1Ba/Flqf9s9gb4o2QaiSc7RHPc9ooEFgf1An1CHnY6QSxxtgg5OZYu3xAGc1HYqyKQH8aRk1AcepkzN9WnVYMg5fEROruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141487; c=relaxed/simple;
	bh=f1By0ymcaZTIG23BA43W25mQtBqnkHYHeOw0JwCpt/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6Cz7zpdEqkOUNQSTKLQu3OM2mimxI86UcygcXMg+zDAk4AvVNtRh2Fzd1hZ/XF7wJn1yAjgRgF/746DhP2SJLd7utmyvdKMrGlXz/dFkY+tPeXx1B5SnwKBttOnutma6BDHkJtzNez+jvvBLMABckfOxFXtbUDcDtNIse0h1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKtp5-00000000bpd-2Wtx;
	Thu, 07 May 2026 10:11:07 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] eventfs/tracing: fix typo in a comment
Date: Thu,  7 May 2026 10:09:06 +0200
Message-ID: <20260507081041.885781-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260507081041.885781-1-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo ("eventfs files") in a comment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 include/linux/tracefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index d03f74658716..bc354d340046 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -30,7 +30,7 @@ struct eventfs_file;
  * @data: data to pass to the created file ops
  * @fops: the file operations of the created file
  *
- * The evetnfs files are dynamically created. The struct eventfs_entry array
+ * The eventfs files are dynamically created. The struct eventfs_entry array
  * is passed to eventfs_create_dir() or eventfs_create_events_dir() that will
  * be used to create the files within those directories. When a lookup
  * or access to a file within the directory is made, the struct eventfs_entry
-- 
2.43.7

