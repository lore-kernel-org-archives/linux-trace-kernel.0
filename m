Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73C39FCE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836418; cv=none; b=KANCl7EUPLnhzNsVyagN/NZGW8lArFD7rVjtty7BbTnXFSAtfnXrtDda19FScQl6Mh9C//M7Dd2kidw0PLAU5leXd0/o/N34t4YpA2vxVV3cxew5XvBnhccqcvgrDFaLmGJyRllLmI5xwdS2JRnFR+dEn/eUTo3wp+Dmzyx6iM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836418; c=relaxed/simple;
	bh=HHRfH3X41hhCOddhpPOPMeRdNO/jeP7c7O3PwHZ4JSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bc10BNMwR+ZRmuo3w8yIKxRHRnP+AeVG0Hn8DkEFxJgZ2JvZ+DiQphoKSqaQeWuOapUAfDZGdgG1GgQbhXygw408DsUsuDTSX1eYVA/twz7qfjFFkQHtj+9cRqAEZrusE8LjR7JO/onYvSJyFfbmAkEB9tyWwhGC3oVBKuLfUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7u4xzBF; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7u4xzBF"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1759502a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 17:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836416; x=1768441216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNPrzm7KtpivJF/6ghwdGmvDMU6ng/7y8+6forJAiAI=;
        b=k7u4xzBFjHxUrRgkPv0M49zL+4W2rfolS64QKRTyV6O20SDQlxWhnR/TSh3/iUcbDI
         Xp3VPojQa5EsLx3ARkR2D/hAzmQG9EfRjLWcA7QhN/6TLWWUd7o3UHAOXMq+gyUlNYN2
         3P6x9kSmRaU0ne1HLr91Ll96+8rRoEV4OL2z+ZnZz544SA7AtUP2PwovlmhoJuYcriCN
         gEaLf67ToI8yfqWPg5nBsnzIa8yuJ+ZIe3wH2d1hXbVgbT8rMFgj+q+1/KZCLjLzqpa/
         9wTaUXyNu8nHk7f5ozKeWxc7Bo8czoZwugc99gk6137DPONmefB+laeseCBPiaifavVC
         fMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836416; x=1768441216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNPrzm7KtpivJF/6ghwdGmvDMU6ng/7y8+6forJAiAI=;
        b=BreqW2Ohp5DVJ8cVyEEzf+S/RZWhgXRkBL19/V6G2VMA3+rwOw8jVOVLP0Lj53mjIj
         6mB4OyHzLdUa+isQnC5vWi+pIXT9d9jQFNrceYRSOB8MFt7/2NthqIJQYV86/Tnq4jGB
         NcILPaJVR5qYs42IQvVX3rpLG/QVQ2hxTlVcZmySJAPaBilzfb8N5itjjDOpB+bDWpDH
         5udXsHB76iFB/WnO/he+/EPjghY3djdv33/tZaYuaQicDfJnEXRwO+HtMHyM7PFA/l8e
         98fdnfLxPp45KY0pUbDrKmHFjMS3Fm8H0EilwdzktVXRI9xUbLo/u0pDnYrJpu3oI+hz
         k+aA==
X-Forwarded-Encrypted: i=1; AJvYcCXHBRQ3HCoZb9aqMZfqpJhvwi2Hj6l2ejtfbA3JCDMtwMdce+pPoLNraYqiul/flS4NReU5rhxAs6sghV+8dKGpD9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oRXQxxCQ2MWe0AytIvwaP95qPwSmvRyEHZvoRgQa7qj8lWDE
	ueBRhF+o5ygE+P6178RzCvOSGU/0WQ7SQSZH0niVmXQDzrJ4TMjj4KEm
X-Gm-Gg: AY/fxX6Z5vQlUkD7l4dMV1Fq5gh+cfhvg12KG0bvsjwE8LXMBFNqeNTAsldAXExQmBc
	jsFln9RFnbXL3cNDxtHB17O/7t2Cpn8EBuTQdlyC3TSAkGlhIoCM7G1uuXRoBrcQXiZpPbkgJFq
	oS98vz1/hIMjwnIcXUVuqt2GMADCdfVQZXN7orAL+RicMZIFVIUTAUG9CL3QKh272rVBkjYcc+b
	hVX0//GpGGq+/TU9ExhHGKruYgsq4AuXb35lPGnQJ8Ex0Z2s0FM/2ajxLmXO4IBbSM4jvHunCXj
	WhOuRArJQ006DdChDDKN2lEfSjQBGnPEHx/BWVjMxVQRH+H97A/I8LBUdzjQL7qvoYbBwwoBgyt
	VxwT9y43HuktvmH6HP7T8lKc4XgRDCMuJce3S5OsbNDYiCdLA/6PCdp80I6eg1vmvKmyxoGhsnj
	x21N+2fhMy71o=
X-Google-Smtp-Source: AGHT+IEOc00Wl1EkUV014Pbq9GIB5Eq7Iumzjn2kIUXu5uwyutQk6/3jrqjjb47OlaBQPlPTGatplw==
X-Received: by 2002:a05:6a20:430a:b0:35b:d15f:8fc1 with SMTP id adf61e73a8af0-3898f8d025cmr4029536637.1.1767836415880;
        Wed, 07 Jan 2026 17:40:15 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2932bsm6453659a12.21.2026.01.07.17.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:40:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id ECD264505E0A; Thu, 08 Jan 2026 08:40:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] Documentation: tracing: Wrap PCI tracepoint examples
Date: Thu,  8 Jan 2026 08:39:56 +0700
Message-ID: <20260108013956.14351-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108013956.14351-1-bagasdotme@gmail.com>
References: <20260108013956.14351-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=HHRfH3X41hhCOddhpPOPMeRdNO/jeP7c7O3PwHZ4JSs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnxnHu3LhDM+8zyLYXnXcuJaUndF3Tl9X/xsN9qn554e 99SZ2ejjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk2laG//5pfRX2kmt5H0rr vpih4TXRU0Pns4Se/bPoNRqHSqdvaWT4H/ByzVK9xYFL77de97y54W76o4VX0oJOBE7e/9F2UtW FNzwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs warnings:

Documentation/trace/events-pci.rst:43: ERROR: Unexpected indentation. [docutils]
Documentation/trace/events-pci.rst:74: ERROR: Unexpected indentation. [docutils]

Fix them by wrapping example shell snippets in PCI tracepoint
documentation in literal code blocks.

Fixes: d0eb853678a21b ("Documentation: tracing: Add PCI tracepoint documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/events-pci.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
index c1ad0fc54777e0..03ff4ad30ddfa1 100644
--- a/Documentation/trace/events-pci.rst
+++ b/Documentation/trace/events-pci.rst
@@ -33,7 +33,7 @@ state changes.
 * ``CARD_PRESENT`` - Card detected in slot
 * ``CARD_NOT_PRESENT`` - Card removed from slot
 
-**Example Usage**:
+**Example Usage**::
 
     # Enable the tracepoint
     echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
@@ -64,7 +64,7 @@ Monitors PCIe link speed changes and provides detailed link status information.
   - ``4`` - Hotplug event
 
 
-**Example Usage**:
+**Example Usage**::
 
     # Enable the tracepoint
     echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
-- 
An old man doll... just what I always wanted! - Clara

