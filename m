Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615653BD259
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309854; cv=none; b=r96LZdEnpmfj8UqEGMRExW3OYvoetoy/bnD9pCWSL/mhg+DLfoi+MTgo/SUMDrLeipiV3i1YRGeILtpaVj/l06MOTpXc6UEGad9kCUZK+QEVhMFtCZYatD0Ke6NdFuQuLSG72mm0mL7WjrvSz00lWVqc/SQLGmgJfEsGmBBhpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309854; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnRrn5HqFLVrm8j4Psh8fkw6nNLgzWwgi7C1S86u2JV8jG6dNJPIsamwFPzgH3D3WQn7LhtuAi04EI/1ahXnPwtITxyI3JTcy9nWcueyelTVNXkGviXhLm6ld88mYtFMuuhymBQyb2aOgbZmNmFguSha4U2K/yD690pJKV3U7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lUFF4zJZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lUFF4zJZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485409ab264so5716905e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309850; x=1773914650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=lUFF4zJZa0hgvIg96v34U0oJWVRFcoFa9sPidhNW/r6tgorFPdAVBUOnJNwV84tpz6
         gMs/NQWS0EqV6OK+nl1tgxtzz8AkxmsJnJ1RtRnpObyAr4PuEOwefSlyG3WECMcYVywD
         imyEd50XMM2nyeLI/O22MjeIcSHIYSvHeP6KX9BEsJU90COAM7UK6UzXwMzGazwkqayQ
         DSTlTolio/zV36wH1/oWeYKJPSdzQaHbT99CSx89fpcnXDqmWHHbAH/RzZIczhVIiNkx
         HaaZlf3v1pSG8xQ9C0jrPB9HyZISmTrKlF+2WMaAT9MArIxRoDnoqYGR+fJ+JAIx0D3j
         iDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309850; x=1773914650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=hsus7G7NBnQaaNSXfHxki1m9TM5X0PrY/dXL0nRWPgWzsb61gGdM7M5CIFoX12PUgM
         ckYRUy9oSInfOwhh79mJh/4n3aU7sN9ue/s4HkGRPBcR7bFEg9XpVYyRzoNaVQuih4aA
         ln3TAkqDIaFk8MP99B46Cd6UzuBLG04qL+MoV0SJmxJTpw41X7u37L8NHoNxiPHeZCp0
         xjTuDEdL9+KxmiIOLyyJvqn6zlJJ6G1OP/JxbCJaQ8MXIqJX3ob3Fc3AWSybLYXyY8Ge
         5KlFYkiGAbiBHmaWhZpOyCo6Bg9H9sQY17kQXPXtIJmEFSPyPzsDnZWY9CVExyrrOjk3
         E5EA==
X-Forwarded-Encrypted: i=1; AJvYcCU+BKA3sc/B98TmvxwNp7zLOW8Wbd4Xtah81Y4rFSsS0BmMZaJ3cLclnaBBbYszAiaKaB8Pf/QP3MP6Xo2V/hOIEzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlF8K+qFj6jC5p5VG8inOlC11P4LjC2N2FO/06pl5u7u+D75W
	Yota89awmRScVGBGqkQ98RRifos4YJkg+grX81F2pwKnd+l3LxyrZDZAO8HxmVqci/g=
X-Gm-Gg: ATEYQzzrqYLS7MSR3TOGl0QuaKZJitYa/5SkK1q9uOT2vHjRAeHZ/tK7XaaE7kQCvdi
	I9v08mDEbcnnOrgE4NEo5ZqIGeY9Pw2aCnlzeFIC6hAUvjOZ1c0ePQSVyJ1hPrTlQn+mMcftkPP
	PzIIZjBfbbtTSFW5hb+IFveT/6KvQq2OyQAMECHsXmdiADIOhdnQTrT9XS1rqPwhpPeJzHmoZQA
	JXPysU+h3xHhoYaY2j5viGrz9lCQOs/mIf8TrM699FocHM+VwXPz5NqqWWYtCmxVz7aXMjARks6
	Opuj/H7L4KBhk4gH3aRS+zQRHUBYd0cnIqG3GpoLB+F2HJsi12hR5Di81tD7GUuNceE9+U0QoJk
	6rG7DCYZlBYMl2xktL0q07o2gTGH6qm3FowQNsCJDlkz/1lqGjo3EFxNN8tNqvc+6/GdPI0STmQ
	RRoPGUMJru/HlvIg==
X-Received: by 2002:a05:600c:4fd5:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4854f578e86mr42674835e9.6.1773309849689;
        Thu, 12 Mar 2026 03:04:09 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm393371665e9.10.2026.03.12.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:09 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/13] devlink: expose devlink instance index over netlink
Date: Thu, 12 Mar 2026 11:03:55 +0100
Message-ID: <20260312100407.551173-2-jiri@resnulli.us>
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

Each devlink instance has an internally assigned index used for xarray
storage. Expose it as a new DEVLINK_ATTR_INDEX uint attribute alongside
the existing bus_name and dev_name handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 5 +++++
 include/uapi/linux/devlink.h             | 2 ++
 net/devlink/devl_internal.h              | 2 ++
 net/devlink/port.c                       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1bed67a0eefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      -
+        name: index
+        type: uint
+        doc: Unique devlink instance index.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1311,6 +1315,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-failed
             - dev-stats
       dump:
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1ba3436db4ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..31fa98af418e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 		return -EMSGSIZE;
 	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
 		return -EMSGSIZE;
+	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
+		return -EMSGSIZE;
 	return 0;
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..1ff609571ea4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -222,6 +222,7 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 
 	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
 	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.51.1

