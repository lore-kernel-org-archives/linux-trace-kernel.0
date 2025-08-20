Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FC2773FF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713462; cv=none; b=Wfykj6ANbEUYXOg593paOCiYM01PnwmbLAtHYP9kbQcUtCkBhBiDh34IpxNjeWJjIoiG6Wf5Q6zU+wGmZFhq2VPF4BvEHuPfiGCt1VhSNlP8s8y3b0AdBDDGICAbVujIw/Ik06Am/c5DVCrmiH+QuUEzevNm35YzS8hiJa/MPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713462; c=relaxed/simple;
	bh=30hBneVdyS9iZwz/B5yGbZLg6bVYoB+QLeHzqt8+awU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DoSGKB76VIOUozA0+cIJJsYiwGzcwnC+Hg+XnuxY/Jp95thzzRygXEd4TSZ26CYbPlky4iXA91VqtLpN+ZOuoHcyqPGy/Ixn+wDZXJniMbINt0NAU3QynUl8l5BVzXv1fBZU9X4+PBc/xqyNovuXggxhOkR83kU+GQZiZVTw4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=ilncVVp5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="ilncVVp5"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b0fa7ed37dso12500491cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755713459; x=1756318259; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtAIVrr8kKwpVUxcVvvrtpb7XAUtMtKSCzGNUheW2Ow=;
        b=ilncVVp5ROW2/RTHYvdWncC3Ry1CM/DcawZT4zDxgF3scq28Kk7usXZQeUCJNW9eaF
         G2DhBm3tkL6asaMdH87FLb6C8MyGKvhMsMqc7QdJQl0cQjh19yhju5obugzNuyoCLtcn
         rO9UKEX/WrMfiUm0D0qOMHVHqxx5xa3OBntzH3hPl0tqSEO/6kpqQ/kYZcF7S38IUdwi
         EiCGkMXvncWGEW3xHHFpOENlJinjxpC+SUUAFwCjCGhWvA6dFTFnLcXV+tz6JRiVGXp7
         cEh5kQ2TwkiaswLyun7un27IBfsFM2tJe+kgNQ7rNFhEkD8BhYzpfAzqwlVDobhq4Xdo
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713459; x=1756318259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtAIVrr8kKwpVUxcVvvrtpb7XAUtMtKSCzGNUheW2Ow=;
        b=Zzzjc0rXrSs82AAFchM+XLUkPkJt6d9Yr4CACvY3JjBNnuC09RjlyeNMIHXk+RuOOw
         93sqeY5Zk+K8C70v8LBdDzBIsrGhLN+fxDZJPGzuF7yCu6b2pKE35slE3wWBbBh1vpgw
         2f4ZW5KR7hBIvRrEJpztFiGsxSfEuQPgLlY3Ch7Si3EyIE9uewXXwyHkGzCYFMNXbBIl
         LHeKQ28v51Ra0a570/c/JCQdFzn5R4vWJxtlEkk+rs9h9JTtyI5ME7DEuHVAIAqEqwPB
         kidmjBjMM3Q4baj3eHnalsd9BZfNZ+8txdt2Vr/81kLw2gpVnnDmxC0qmCEwozeNfDZb
         xKDg==
X-Forwarded-Encrypted: i=1; AJvYcCUX3nwtPCa1VA39Kz4CrH3a35hecK7UXD3v84cc4lH4/U2Zw80GuRFsJ97Nw6BBKXuSB0P3ghsmV4WoFj3VVPqcNYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7kpWKLRWoPoBxgqSh7sY0PKK3M8QmtdRv/qzBScflWhT0Pu7
	KK3OPqjGraoEKBMzX6rM2zdgB8D4EXDsJUuPunrLeehWrjbEmipsy7PVjNbZbaaOzA==
X-Gm-Gg: ASbGncvCCBFTKxfsjRZLxcLaJ5aOy0qkgaHMYOG1vfS98CjKgMnl0SIeWKrkjt6zDTf
	2D2M01IjUMSlBNVPN+u4qnq2LHso2wVMWOXVuVxIu/RUu038crZgDpfh4lD4h7y9EWR4jXwzVM6
	WNaZKNe1+9lI2TmF098Mh6Xn/YZ1KmMneINJMS5w8AEyMj7jhTiNgJTGCWLaLm4aw6e+T2DV941
	LQF3jVr92hbjVoPa6GXPEcVLb5rHEmHHc8wFIhbIHsHgOfWwjZFVBnrJ9ObYePOGFgZ9S9mjbkf
	vknRrIMXC9m5LJuehfx3uOe1rNhavFKmdtwF644LS829Crw07C6H3Lw8lXeT/qeKH90iCr/BruD
	ZotEsVLrzwJOOLAAl33I5AyJ50Fn3lpFQv1Qrc3l9VLGSzAzSICNqbARkGsdYFQB44R3ZNCA7Id
	NYgo5ZNKwQkXLazQC7+kkLLUJ0QKirSY38RRcMmYPX4+zskQ==
X-Google-Smtp-Source: AGHT+IHfwF0SHLGbBh6c7/vZywX7H0BigZ2QG6D5oe4Z2s4ohRyshmxOsFLeEGyGni+YNfdJqd8KSw==
X-Received: by 2002:a05:622a:18a6:b0:4b2:9a53:7c15 with SMTP id d75a77b69052e-4b29d6cb53dmr5722711cf.25.1755713459313;
        Wed, 20 Aug 2025 11:10:59 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm977497485a.36.2025.08.20.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:10:58 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
Subject: [PATCH 0/2] PATCH: firmware: ti_sci: Add trace events to TI SCI
Date: Wed, 20 Aug 2025 14:10:43 -0400
Message-Id: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQPpmgC/x3MQQqDMBBA0avIrBuIgVTsVUoJQzKpA5qWmSiCe
 HeDy7f4/wAlYVJ4dQcIbaz8Kw39o4M4YfmS4dQMzjpvBzuamcu6hwW1koTKQSOHKhjJjH1ODvP
 Tp4jQ+r9Q5v1+vz/neQEOqIxMawAAAA==
X-Change-ID: 20250709-linux_master_ti_sci_trace-91fd2af65dca
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=30hBneVdyS9iZwz/B5yGbZLg6bVYoB+QLeHzqt8+awU=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBopg+xuRBsVzXaYKYyTI5vBfVW51jOnFCmZ1pIw
 ALJl+D7eYSJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCaKYPsQAKCRDc1/0uCzbr
 qnE5EACMWtJmoFWZA+MCgRUIDFZR3DCrO0PRy+5QYmFUEZxTCaxsULzwf3WoegqeAkhtD8wPqQH
 0swjGhM4l5p84Y/LbNS1US6BfVATP2zHMwp3qOwX9XOYhIieOxNqjT1Beawu218666Zn8YkE0on
 Wx3/64Hf2mv/SMPV9RUv6DEZivri6H7RKv+l0/UrnNWE5U17CAPOBCRBY4mLPEdw0it/37FbdE2
 eG7sry5a4qI6SrT6uPND93dFai2vqkcagDBE48BsZOpwfNcCP3UAuhoXupUttyTpYel1sPRKAen
 kckLOT7o627QYo5ASWVAhgl1x5gJmIZzF/gTBBV1C+Zr/9/baAUSsDGdtGJf7VgyuxXBdQX4hO/
 CZ9neF0EI/8wTXntdLvAnIrLi17PVFmdzUVjG3i5/r7bJH65eY1migrCCQI6FfJFv5zhxAHiFTZ
 LvgRJjMXKTFHJjUIaEx63lVmPsfNACiT13FzzTBEFiFLLFpCXQj+ntVeInRhFpGi1pVvLgzEvjT
 cTCSaDC54RhK0upW+mCaHZVvjSlq4svDQ/8Y+e5vzhHX60aEYafZlXpJQtn7VJMcruc5uPIhkmC
 0okS49r2Q3B3nRJbCS0hXYHEEo323eSc/P1aA0QfpmwKB78FoQpyOFoXwVW3lMv2VpVKV8rN6L+
 aF+I49vn205iukQ==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA

Add trace events to help debug and measure the speed of the
communication channel.

Add parsing of the messages types but I am not sure how to parse the
flags, since the REQ and RESP flags conflict. Left as seperate commit to
make it easier to drop or make changes depending on comments.  The two
commits should squash easily.

Nishanth Menon and Vignesh Raghavendra requested I send this patch
upstream.

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
Jonathan Cormier (2):
      firmware: ti_sci: Add trace events
      firmware: ti_sci: trace: Decode message types

 MAINTAINERS                     |   1 +
 drivers/firmware/Makefile       |   3 +
 drivers/firmware/ti_sci.c       |  11 +++
 drivers/firmware/ti_sci_trace.h | 146 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250709-linux_master_ti_sci_trace-91fd2af65dca

Best regards,
-- 
Jonathan Cormier <jcormier@criticallink.com>

