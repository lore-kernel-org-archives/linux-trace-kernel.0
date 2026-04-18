Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F702DCF46
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Apr 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525776; cv=none; b=cnOWd3imdqRjfXaMR1k9udJdOFhJXfcWFkJ88wuH2xzxC7KomTUrW+PJzPhEPQF+t1dD/vReVW8635Kh+GXfCGllk9W5ldRImorYxTpYuFT/u3VzPmhWbmGgFc5pqwRRRrrF7IJVzN/0erJ9WqQ6xJ4Ba6lt7+oGAyAtjUa4hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525776; c=relaxed/simple;
	bh=wMIQQgxCfalY9WXiOfBb13fu+fvGlMWOcyORM73qBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5i+TAM1zTyXB8E//LDPlku4fsGwXQZ9low0M+WoMpkCJdMpGbNKAvfk2/dOEDGVnZm8tuuw5IL/3ua77R+js911R4Cz0nHAyoLEYZE18Cs0N8WDy8dqtzDPVBT8GqHycrZGxTtu/4aGXXdcqZgoXxuTD3z45bOaHLIj7lIEzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK9wBP7G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK9wBP7G"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b8efed61so16648125e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Apr 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776525774; x=1777130574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMsRufTR+ikJPYI8IiM5SL7gmmFmr9I36g89RZG6mjs=;
        b=aK9wBP7GbP39FZzCQ9ZeYziaYq3r01bqVRsidr4WpSV/MQruSSQyUl2lhO7ZEkUIT6
         A0wjlyslNLy7QN72YY24/gQ6CDGSWwfn32/mN1FNJm9DWvUQkPplaReRztPwcslQTyRb
         4NDzX9m0ioBFC31n62aJJ/oa4tQ6BUoN5jiT7URznaXn2LQoeknQmNiWvPqWVv0z842K
         r0JQk9FAbiEZNNzFdYgnszdswPInWIqlck2RNUh6WMTLq4TSGxg76Chmq3eNWdbJ8vPF
         GKFoNwZ8QoqINt6lx8BsvaTxfAnVB1Jy8xY9ge3fu7MX8KGZ6ygML+sqMyFMo9io5r8T
         5zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776525774; x=1777130574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMsRufTR+ikJPYI8IiM5SL7gmmFmr9I36g89RZG6mjs=;
        b=rpTpYYVNIWC4ojNuexyd24ckEQKRZ07wBJxclM02wVPbGBBlHu75uppUOBggore0dE
         TcFvp5c50ffpflRdvmhNF5y/Qw4hrCwJrlEh4kt+GtosMu2RQClpOQXe4OdJzRCSDvD+
         N9KeuLhvaSanuMEIs7q7Ot26c2e1vUm57i9OVyYIqkEj5ykpBhKiZe757KOk0ScFcdGP
         pQlGOw4OOHCehhblwSi4u2MNUWdOLSJ2gJtg9uEo8scyYshCOAq0u/3Thi5yo4MMrFb6
         0FA2P3znEJWTqboOIhtmNAGl9Mfg58377aUOtqh4Ct7S4q1GN8z2/30FH7t9NQi5L3cJ
         VRzg==
X-Forwarded-Encrypted: i=1; AFNElJ/KTx+HCVCFEW71ej2FTseE/FT2bcsoo7EjMwf58il/ETWmo8H8BquIeir3/IzizlHlaoXMjUpzbovRme/EyGlG62w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiAE01XgnmU3U8sApfWhoGAGje3zk69YX1U3dMEIdLDrzzod7
	nxV5jH7SU+YslfTVhxNoqC6QHv1RSIpjjxJyToWnOyio8G6EbGgi4m6b
X-Gm-Gg: AeBDieuzR/GY7x9MYd9rkGpvYUWlB9RKNuO/JWzMkwcYt+PIzyAvIP+7/jK58KZarDA
	hLl7W1YAKuSngevVe8nlcj44FGw8skupsxjXzMYwh6gmn8IN1tGpQ06cTuH8UzS064MfJSoCjPB
	XkwmiUsT1vVEKfYVgJ2x0znwnMRjEwZKOy6pMsGLwO6BVWDBTnglmUYdQZnnsoqbij32Uc0Co0H
	Ul4EoWJMUHt4An7LmptlMp3d+eintJWtXQahBUIF+wHaS25EHoLwqCShy0vJKFoGAHT+xw9e3pr
	Hs53FL4QrGy5YhRBZ/KdvfTCW/TzXwuB4LgZVs+ofK4jO6tGPw7c3TzU1+7b2262icCsPhb/7mL
	XrbVtMquoME4jUmWb4116BBIvKM3p6M6/cOJ3QlLhhEq0h/mw3o2epwFOf+wqyafn7Ltq/UKi11
	OtrQLIVTGozKM0x1bOiIqRZQ8FJohC8tqvFhhYOM1Pj+9NaPuJgTewI6wxJFxm3ESJ7nZWFa7hQ
	88lqCK3u+hHGxqBkEW48Q==
X-Received: by 2002:a05:600c:628b:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488fb8afffcmr97497815e9.9.1776525773621;
        Sat, 18 Apr 2026 08:22:53 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc143a0fsm144564165e9.14.2026.04.18.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:22:53 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Use list_add_tail_rcu() for SRCU-protected children list
Date: Sat, 18 Apr 2026 16:22:50 +0100
Message-ID: <20260418152251.199343-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..8dd554508828 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -706,7 +706,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
-			list_add_tail(&ei->list, &parent->children);
+			list_add_tail_rcu(&ei->list, &parent->children);
 	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-- 
2.53.0

