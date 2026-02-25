Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD13ACF02
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026471; cv=none; b=l3/ZkSghQyED2ec6bYLosG2kjM/qCHRYN3m21egaZY6LBnfEJoNM1V4gknUlfuTryAPHOm9mpk/xB3n5UPIxeGGeA/86ubcEntXOHYEinB9d52o8UwMRrmg48kBp1kaw+320oTuAGdANoN3yl3E14TdwUYqj+9c6yv9bt8uyzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026471; c=relaxed/simple;
	bh=PABzC/qYg8Go3kt1GXod1fs3aKuZpPfkbvp4LZZhDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe4mmkAfnHI7ahtwjfvqcBB8gX7SCQ1M2sBzfI49ktDNccBggcSTCRgDSmTWgRyUYl4ShENsbyZ3BQG1zAaHDy074SZkxX/r8TvJA5hR9Lr5E9skaw82MuC2ekHO9dOnnP/K/gilLpNEsjhZT9s0O4MlPKC9FxaqFOb82UibqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YejnM16x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YejnM16x"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48336a6e932so40981595e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026468; x=1772631268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=YejnM16xnGU2GKt/KJgJ2dVqhRyS7HDZAizyT2sZHwOUi400ShfwOlv70+hLTHTb0D
         HODTMfMp7yb4lK3hbV0cxnIyW2Z+uBOYiZZn7o3kOGp8HJBt2BLEeKrxuNIJzHqDJX8J
         4nMjzkXVjmAOVJcRGJyVN9chfknHG/sksb1Z9kf6u61FXousetYPthuYXUtAawYGWSfL
         ykcDh5RbPGNnCZCPWprHlq2UlJAhW7SIxBpbngZ4MbAL/05ch1PY3NmP2/ua4aPoxMOf
         qeTWXqDNL61U5db9qiWg6649HeJqmJmuLi74w86ZeZj2lvXokMBvLJdk2NyD91wTW+N3
         aVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026468; x=1772631268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=emlPRS98V7FBtpBWHwj5KrIBDFqDyHyp0V4qg9wswLxbCUKBxKF0w17JzP84wGMHz6
         zxsXziR6pm+dW+Olh/wbS99yYE8JpS0L9VSGyTHcMic2/ico1oExkeu6wMqvnwzAiWvb
         kEj3MJitwtN8XcQpq1/s5L7dlXH2HQrqveCy+ZQFXaJ1n/TZN5bSILTdzww9qCfPv7ne
         33Xe+q2juGjShtq/4b4xbzNan9+iMYmWuqBvhgDDYkypvlG7uuig6pkef/SeHaYAvkt6
         FQqGDgGe5YB9qLcOSD9FAbeyae/K93sozz4HF8BJFBReslSp0mTVXVHI8mgtAgcruNLP
         Asiw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+gxk1CSAANdnhTImFikSgQL1uIqhDiQ0Om0ndUzRuN8HgGlgwqKxW9T2ZFZcVS2Ztd0iXhV3VBOjjJPEuMEHaPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLfsiikyx4egzS5w4SZQpASeq+BI2xR/snpcJeW1kkDKtrSCP
	36OgiLcoUDcV17v0sXtkoP0hHHRtF15JE11Ujwha22ai8sf84Z5a95p7ql4jOtJ3mCA=
X-Gm-Gg: ATEYQzy7wPtvANRzAdM4vi1jNc3IiYh12b24t5qt6Lz9i+d74aRcAUyGa7WKXbj7hHA
	ep5P+Woxzm7FQ5j3uDexAp1gD2lvN3df9C9ArOGwAlf8UFoyN1uG9cU1UH2glGsmtnXdtp2M1k9
	BCTdTqZSS1zJuy2L7AzZzb7N+HJVe2MvSLItUKBO+Nfu3mP6XXHQy1lmzO9V3ua0LEDCx8zsyJl
	VQ/4IvrMAUGf32DC2fPLgQYRz/dOdzMY6FUSRdxNG5ioS3lAGN+CTWBEBYhbLQUe4QCbglHlOPM
	KsAOHKt6GrFL+15axTQUc5qRi7Dz46mCWNpeZK/jEtckceur9cBWNBmv73RPk9IXhFcbci6en9S
	q/1zT2OXkydzNGEehN05CcK8I1OeZqTiz3pBaGOzhfgt9lKTj+3bsHkWNlbiK+xidLrin65eo7e
	tUYLCz2Jj4pCis6Q==
X-Received: by 2002:a05:600c:45c5:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c216a9f6mr9402805e9.1.1772026467742;
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd732eb1sm71670605e9.12.2026.02.25.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v2 03/10] devlink: avoid extra iterations when found devlink is not registered
Date: Wed, 25 Feb 2026 14:34:15 +0100
Message-ID: <20260225133422.290965-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since the one found is not registered, very unlikely another one with
the same bus_name/dev_name is going to be found. Stop right away and
prepare common "found" path for the follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 3f73ced2d879..a517d42c7b96 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
-		    strcmp(devlink->dev_name, devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink->dev_name, devname) == 0)
+			goto found;
 		devlink_put(devlink);
 	}
 
 	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
+	return ERR_PTR(-ENODEV);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
-- 
2.51.1

