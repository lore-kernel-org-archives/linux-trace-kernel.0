Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6323D1CB4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026478; cv=none; b=t8IUxSng5OH6ifatnOOF8hp+ydLvLpNephUGNbbLKy5eTCmQK5uaVqoykdzm2tiLmIKRPo3E2gzpWJel+2efzdOHzZ9Z2AAug9KT4FE15E8i4SWc6gnpHWFjDKlh7i0P1/Qh+WBnhe8xjnALqPntkAzAaOVKSmM62jobu0vaJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026478; c=relaxed/simple;
	bh=z40VzN7RJg93nuVTx3uJj/QFEihxo6bbSBkIUN0ad9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAC1cqjg6vX0TwNLWT8BdAlLt9ft2iv2LgKMnj3buOww3wlDb04nEe346g9U5da5RncPsHsUTkCcYV0ZZAFyedumHvUSgsYXUpAAQLfnfim43tdfsrHMpkQq4JxSqCppvccFquVURXMh513lgkmgpUgH6d5iJQidvjjGFkZrngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GxCVFlE9; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GxCVFlE9"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483487335c2so60093415e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026476; x=1772631276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=GxCVFlE9w7w5HUov3ZrFteu4Wm8d0T+Ec+z+g9I7ZLDLOHXLkgpuUSvrglJuAKF5Tn
         6ciXqENK4sSSw1OaEuFX0hOfXvrdVMEmIGho4THe/JrEEZPkjomdhy9++5q8jQb55uzi
         Jk/LmGl82eQZ92YbQQxKA5vRIxo86HT8cWFJPiokQQHhWMhxtMqAV/VtUJmOqdjkiCxg
         VDKVDqaRbvG2PvE7i2H5fq142F7iClzmn+B6OYqmM26AnzelbtQUE1gbfGpj+Py85FeX
         2k/+LpNV5uPoSQoGp/2hWfbiZ2zLX5csqGRZ3Uc15Ygf8IDSTUGFYC6OFj63BloAlHZR
         p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026476; x=1772631276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=t0J5b0q3qjbTxpFtx32bIoUsSBfZt4xtyV1c7EIqkc1MG2OI1gnvOw1jyvSGqLmEtL
         NLWWg5v1oNMZDGhbeEj2lPJ/l5stJiMOKW9m5ANofg5XOVrLLgPlIJaCvt51m7WpWL3p
         sQdHgCfOeW81aTPZOXOl4xQzDUpQrfIMFgZiYO/KYk3Bv5LuTWDPgwr9jExPvp1npZhN
         FNY9NUtmIq1JqqiJW39rMN4S8KquPBBXPlqxui2v2+46xIrd/JOAwnjmji9roCnLIdbL
         zz95G9NZxV8P2N3oI8A/Se1RzLAe+Z9dh9OsR964qXEbgNlZswVAYdsBtR0blGhTNYdr
         XiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj6YOPU2gI8ojFRzIQOt8V6n/28XT2WtfJFz/hON1yrxlXcklnww4T+IvjkeXzwswykJpv7XbhtYtB7t4S5pq4SbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyVPjd+IaxeskX//iX370FnJxf+nqQfwLwoQ9hI1rLY9239em
	IwKjuONDYWlM1CZyy2nZadHYA0494ixbrVYPn5PTtJePgy7eBlhL/jmD1xCTp4HcZNg=
X-Gm-Gg: ATEYQzy/3OT/wnwP1s4yyVSEy5NY05NB0Wqj3w7/xRcxNd+zSutVWPxTR4UwXIKYaZk
	dvUBkdA8qd4Aj0C215SWjudAkvUbdtaHrckqDtkjQ58bZPkstEugxoezVJXFDZyTKbLgTOe3RIy
	mHE7byy+P8pOykoRImh63kYW2/K+Um69SugZuAAneVg5RX+URBw2z8yENYFAW+fa6ln/TAFEdkj
	DnziVc8NmbSCEZm+S/3xozTEA1WvoVu9mwrHerZvTt6dwScgo5R7/FrUSztUEv1k5c3lsutkaX0
	HGLcs9yIyGKbAdQoW8zN8wE8lsx7xEMbuC6V2s47oUb9iWeH9UsM4tbRv6hdUVHmWOLSgYYBeU2
	GlOv96pXg/kyymUXqeJttRxj7Rsh82E4cy7JUbseg1gXZI4qLGGn2P6YxXI3fxQCD3dDe7An3RS
	AcFmkfQU5NHZOF6YbJM9CQ240J
X-Received: by 2002:a05:6000:2403:b0:436:1590:f9e7 with SMTP id ffacd0b85a97d-4396f15cd3amr27471526f8f.12.1772026475499;
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm11713836f8f.7.2026.02.25.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
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
Subject: [PATCH net-next v2 09/10] documentation: networking: add shared devlink documentation
Date: Wed, 25 Feb 2026 14:34:21 +0100
Message-ID: <20260225133422.290965-10-jiri@resnulli.us>
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

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed number of "="'s
---
 .../networking/devlink/devlink-shared.rst     | 89 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..4043f6647243
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Devlink Shared Instances
+========================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share an additional devlink instance for chip-wide operations. This
+is implemented within individual drivers alongside the individual PF devlink
+instances, not replacing them.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+The shared devlink instance is not backed by any struct *device*.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation uses:
+
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+API Functions
+-------------
+
+The following functions are provided for managing shared devlink instances:
+
+* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
+* ``devlink_shd_put()``: Release a reference on a shared devlink instance
+* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Get or create shared instance** using ``devlink_shd_get()``:
+
+   * The function looks up existing instance by identifier
+   * If none exists, creates new instance:
+     - Allocates and registers devlink instance
+     - Adds to global shared instances list
+     - Increments reference count
+
+4. **Set nested devlink instance** for the PF devlink instance using
+   ``devl_nested_devlink_set()`` before registering the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed
+2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include:
+
+* **PCI VPD serial numbers**: Extract from PCI VPD
+* **Device tree properties**: Read chip identifier from device tree
+* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
+
+Locking
+-------
+
+A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
+
+Reference Counting
+------------------
+
+Each shared devlink instance maintains a reference count (``refcount_t refcount``).
+The reference count is incremented when ``devlink_shd_get()`` is called and decremented
+when ``devlink_shd_put()`` is called. When the reference count reaches zero, the shared
+instance is automatically destroyed.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.51.1

