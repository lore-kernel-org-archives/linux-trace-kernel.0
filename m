Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFF3BE620
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309864; cv=none; b=bk1CAv5ld/5qwvoFfFF0aqm+qFrYnvbNAwJ8NtKK+jRdtQ5Y2eBERassVG79wCtqUpFCaglhe4ixWllFhxsk/wYMgLA0MQQCsZ96MMywZRWOI5NjnSmjflXns4BbCb8fCWUER74yftur43Usqeif0Fw0mhbZXCSl8UAQb+yRtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309864; c=relaxed/simple;
	bh=1WRGLRV1Mf3gtLoQpSz/WpelFSk3nN1ML07ryNxiF/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfzgKIBvSYnf3HobgbnVJ2nfh6jWgvdjfhoKb4c36TmBzDpy5+RO/FqtXk1hZhWbJuXLfUC6pPvWMvUmhG3rgbTf1/ktsUSqhj8iUwx8ny4Zd2sx5AqUmUhDQpDY6hhj31FvrHpifA3heBE5pnQEdi8vTFjRCD3NepQeaqwdj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Fg9svybA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fg9svybA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso516219f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309860; x=1773914660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=Fg9svybAcoL/8W3TMV8UD1aita997P0m/lDmRNhHElXkBbE1/WCbgS7iQoLWF2/H5L
         9ALqht8tNXwyv6UehXx0G3Y0kM33W2jUX+egpH/Q/Jjr8nB0srr9XmehLdJF03P8hWso
         IEDck8AQ/u81W/ZsY2i1oRmrTPuOasmrsUHto7QCdwPPz50+4O9QxQ3jLBTan2qHidna
         oX7pa5OGcOzUu2Sla73tAJFcGnMseXEgnEKjf8yS2OIXQQuHqnRU8YmDuv6mG7f8v3/T
         zwSgH2wICBZpf5koM7412QWwXJFyqGNYKrSPgyNQHY+hMfEONAQjyrCALRF8OEj0/8dB
         Chiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309860; x=1773914660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=Ef/2/ehxaj3ajQjPVw30fo/Um4iTmzJeQPKq05mHUuZTQ46Ej193aLDL0iBm3URj8b
         UpCax2d2HuPR2x8VxJlN9yHGvIgZl5xxoDnop1MCb7fgqJKIYyh0DdNePaUd0Frrexrx
         oJguT/oHdB4m6AXPlzKZ/gJJIdj8T72SaPs0T+ollLZXkXXCE2IOofCM7sadi+2ZWTr6
         XYcWroWL6TnDZ90Zmnd9cklMxC0EAjEha87F0Y2z2QT8jU42PXRuYxRUU2AD9md7Vt90
         8S/ZQdQ4ayQ4ycTxnJt5PpnlGS1jXhAceIPoBWb7dW4A2B//Qy4LadG6esfirfVb4UAU
         4tfg==
X-Forwarded-Encrypted: i=1; AJvYcCUFBGq2bEKaEXPZdmSTVn1iNNsKMcmO96YNVNt0w0uwUsa7OtatUhl6srJSHKv41v8ZkrmV+9YRq+Kx9BP0NtUJheM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSTtuPe5htUcGkmwhwBOK3GBiMauSXsJgYwY5Q8z/zUIf7ycs
	qYZxxG1hFkwNNBB1u80Q4BI+axeuvT9DNJl5x1nJ4J1iVIrEeDzYSUy7kblIYI6NsbI=
X-Gm-Gg: ATEYQzwIwMHbXOTBn++crpj5cW3hg9CxFXTyCB13Oj5isD5+SRnWAeaYC08uQuN0BZU
	Msk4lB3Ag11y9lxTHeFzdi9pTFNDQDvg5QX3o4VgtmiULbvyyW1L47+rnvPddx+xNSurBiyKzVy
	NMHKPx4QkOB0meGVhjKh+pEq7NWYVSdf2yXs2htCxiIy0TxmwRRCYzrZVP/VlisBNd7BN1nPE4B
	Jq3GtvP/CZC5PNqITiPA6EZJquzW8xxInwPGUmZzzgzxgrfNcQwIi/KD/2OWNWB4HUWKW03kWk1
	fBSi8rH1X+hlBc7+LjmGq8v2AgTZr+a1V1GXJJvCAzm0p62iFOCggPaUEQqvWNHuZwDctY/BHoo
	EnZbZVbP3+JqtqlbhZsFE6sW7I0jz1qM2mqRRT/mdJfqlWUarm1XERy3f5hrdFI2E/Qr+4LOqlx
	HGxThYmlNmZpX5TA==
X-Received: by 2002:a05:6000:2681:b0:439:cb9f:d635 with SMTP id ffacd0b85a97d-439f8223054mr10822988f8f.46.1773309859695;
        Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm6305802f8f.10.2026.03.12.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/13] devlink: add devl_warn() helper and use it in port warnings
Date: Thu, 12 Mar 2026 11:04:03 +0100
Message-ID: <20260312100407.551173-10-jiri@resnulli.us>
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

Introduce devl_warn() macro that uses dev_warn() when a backing
device is available and falls back to pr_warn() otherwise. Convert
all dev_warn() calls in port.c to use it, preparing for devlink
instances without a backing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  9 +++++++++
 net/devlink/port.c          | 14 +++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 3cc7e696e0fd..cb2ffef1ac2d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -71,6 +71,15 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+#define devl_warn(devlink, format, args...)				\
+	do {								\
+		if ((devlink)->dev)					\
+			dev_warn((devlink)->dev, format, ##args);	\
+		else							\
+			pr_warn("devlink (%s): " format,		\
+				devlink_dev_name(devlink), ##args);	\
+	} while (0)
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
diff --git a/net/devlink/port.c b/net/devlink/port.c
index fa3e1597711b..7fcd1d3ed44c 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -976,7 +976,7 @@ static void devlink_port_type_warn(struct work_struct *work)
 	struct devlink_port *port = container_of(to_delayed_work(work),
 						 struct devlink_port,
 						 type_warn_dw);
-	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
+	devl_warn(port->devlink, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
@@ -1242,9 +1242,9 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  */
 void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	dev_warn(devlink_port->devlink->dev,
-		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-		 devlink_port->index);
+	devl_warn(devlink_port->devlink,
+		  "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+		  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -1273,9 +1273,9 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
 	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
-		dev_warn(devlink_port->devlink->dev,
-			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
-			 devlink_port->index);
+		devl_warn(devlink_port->devlink,
+			  "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
+			  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_NOTSET, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_clear);
-- 
2.51.1

