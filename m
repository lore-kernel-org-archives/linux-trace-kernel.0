Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4623BD658
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309859; cv=none; b=rOUHm6KgBJJh2mFrHFyuTu+Tqhqxepp/acjqHk8r4GtEbJWsq2uJzyOjPFZ+iN+dmC3S0plB9dAR9n8m9tgM+lGCEZDfZ+t81LR/3ds08ee1CO6lYHVTd5cGKHidifj1lgqlKOIDJJRtYs2EsdgARVAzUODnPiy22otKhfPGx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309859; c=relaxed/simple;
	bh=KKgpf/IuVUhdHxdP18sDxJ2z6/oTRbCGNRlLhLLutN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgEAVzNzfit7408OktqdyZIWi9aEe7KCXxo4/l12t7um0HenR/fGvbJ7XA+PKZMdDz6DazCEQJNxYgOWm4muERq2ecxvuhD8JJXRN0splV9OZJwU5wO43GUqUwe+Ccafwwx0aDPpQ5l+hLO2v7I0HYGgenSfBZ7fu6E9w9vZ6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E8+SKtWF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E8+SKtWF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48540355459so7040245e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309855; x=1773914655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=E8+SKtWFmwDJCxiHR7D6hjewlebDTzmIX5H6aMokblPjp1kdPTCOZAlV75KmK4vPU9
         S1MKdD7SKWApcat42ALG1GNeNl6v+gALfSCMVwOZYiL/eoCG2GhxED0d066M8d1RfM2+
         XyNKfLPNqWqP/1/yJ3TjdfdvEoOW5fGju04J6PktFh2fEHDeMAAr9eEMA8v5+mc35bLc
         2foekThgTl03ePc7gC9H/WIhkQlTFHu+kawL94nkOCquUm0q9jKW0wSBWTMNs5Xe0VG+
         z50iivAWMCL2Nc3iYziO8g79ktvF0fdzlgdZDC6Een7uUjsC2DIPlWDSjyJxeFrTP8B5
         ixeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309855; x=1773914655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=rCklQMN+krX1DjQNNFgUaWrsQLJMfXZFnshwvkjso7OLuZHo9bBdfno/pSjNdrpuUf
         RfPCDq1zlw2e8hjpytbggb3hKKZ2vAEpk+gyK6y3AiKcYWdxa1Xki4srvrHNMis7wQDp
         5tHXA+7weI2RxII+esPIIycMto9UIJh4Gvbgr9/X2SmnuKeI2mk57w6NyWHDyyoUy4O+
         uoEqZx68+veDF0DRv7EkyflL+0YAtZ2xyUEjeFyQwo2gLa3M42kkCdq4p6apIOT46Rkt
         w5cRixKqOVgxAjd4a1zDiq0pC/XzOd3Z8J2bSafruYG8mGlan3I4wLtrf4C1xnrue2kI
         w5HA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYPtmCCjS2w22FzbbWvDjs3WNcP3DkUiurccgwOYSUV7gcg61gccRHiOCqtR2EDLxSHgnC4P1NhIPfpSypGKCQ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBQOe3sRN8aaHwH0yMUUqszMumn/+8vEIV6BPXAxnSm7RvlPy
	vzzOW/71KygQ2516xMeLNVhRE6w2iGLIyQtanrr6NYvSPsffyYJfLYB+DLemXFuioY0=
X-Gm-Gg: ATEYQzzw2B4KBG7tR0ulGV0JKGcoaSKSrfzJNn/fOrjowQASGAU1MDvpmuurhp9B4CS
	DA99fvsm/DaLp6YIB1ahduTW/Zm8dWHy82H4fC+lpSaZ5KHL/aZxTxDLJWxdnhjdG1c7Yd1O4dJ
	IfiKNuazsIkjv//ErKuUYSqyaD32jOJ76NHRKNyuI2UH2msuPS0wmIYRJnyxMRhO33cb40xUGe8
	ygsAggCwALGKP9yeBGz+5YCBtw6edzDdX8YBGX8oeS+eW3CKsee/Qf3erSCz2PIuzHCVLIjzb82
	9w/N7TkYUaW/n69PeDTkQnecuraitY9q4mRgdlSB+yaIfjAMk7ZyQReCOGru4AzgBTjZpTOIwmn
	w/+j85B4o6lEXltQgqWHG6PgOpoYD/zGYyostwYQAa35Eu2SUiVX386jdbUt+JvEJlmx738ADul
	Tlie5pV/QWLwTAohxIxvugDguR
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4854b0bb5c0mr98639645e9.13.1773309854890;
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm97596925e9.1.2026.03.12.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/13] devlink: support index-based lookup via bus_name/dev_name handle
Date: Thu, 12 Mar 2026 11:03:59 +0100
Message-ID: <20260312100407.551173-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- unify return value -ENODEV even in case non-numeric dev_name
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 9cba40285de4..fa38fca22fe4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -203,6 +203,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-ENODEV);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
 		    strcmp(devlink_dev_name(devlink), devname) == 0)
-- 
2.51.1

