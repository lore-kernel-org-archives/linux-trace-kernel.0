Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333972;
	b=F68A4rigoMfoq7JKxEmxRyIdG3yVNmrI+7x94mzhlyEtC0zvCPHRxEzceWlub5yg6SxM
	 a6vMS603VlYK87RRNncT/WymGcxrKJGA8TbPaU54zXBf5Vn0LJC1FkxwlB7+k/km+xK1P
	 7GDQo38DnK78PSf4ZtDxty7PyrMVYl0XSNPR42yqEpjVsksW+OBXETUSKbAh9fKP2Eq6/
	 zRKrZHtgeUlpLQDF9yni95IfyquoKy+gUm0AkrEms0uidpbBY3U6rmCvf5jROIKkd+KIx
	 tCVLCFAk3HA9+AOADn2WbjTFQElwsT4qpNKh6a6vqQq0RN/cABnz0mXT0Ud8lqNXXug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W/ljMR4xePjF+MmRD+P76X/dGy8g1SjPxGW0noQ2CqQ=;
	b=HUxYV8muLA90iwQGkIS8Ty1Uu9EafMKlGKkdicVDsoGc4f+Rz1JMbZ84Q/Q9BawtBUJ4
	 pOdK4wdyoEozpgGgK+IGPx6DDPOtMR6JdbyeQdPJfFqa6fcSo5h7BlHfcwDDWiKUnl3kf
	 jrDXtukTvPfKAbTWEfRW8V3Qyx0tvpyNCt2VjEXX/17J9qhUgQVUusQlhlPLOB2vWWLrT
	 /eibUsJcoFYd2U48UMHkktU1KWq7/r1A7Md81qothCJVsPEufkci+P687bhe0FUCIPZY9
	 Q9KpxHIohjZCV3W2EQHY7Gxq6iRoHmfpK2mSqN9m+Yl5z6vyxAw5wPUzjVeEA75smjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLldxySr;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E6606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D75E6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TLldxySr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso16336955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333970; x=1794938770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/ljMR4xePjF+MmRD+P76X/dGy8g1SjPxGW0noQ2CqQ=;
        b=TLldxySr1OjK3JsgfFfim9ttHsN7YfVYNshcRm145+NJRGMRNa6iX4WH/LFxP0kdVo
         gdAjdi/AtB9VKrdPwGvKo/biHsE4wHbHIbW5e6WD5DRBU/sFAM+oEwolt6DjyUCSUYPL
         x4v/ZnSoMmWxt5KCdvyOpqeroeOqrDgxUt6qs76MtANO5lBxM3f3kRRPM//pnWJk1kSz
         7XYk12pGubCWLfTz9JCnF8B+thjKlGR9byzqWPnY+59pJO5aVb3bN6lDOgRkCz5FoANB
         Z0sEskv2vmMhJ7qWMfBU4wPrCFxreqxREu7E9QIc/v6P0CplkYom7XlkSar4xc0OIGW4
         +unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333970; x=1794938770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/ljMR4xePjF+MmRD+P76X/dGy8g1SjPxGW0noQ2CqQ=;
        b=lFruv13KGJIEVzeFX4rcFwuBFyvaNyY4E02m/PM+Tnxi6om/G1k/V22rCZEB91uQ7j
         eqnUxs0E0OjTLzPMDzaYaVTobqmwWxYUjbL0sthOHEzPvA56eklrj/dDnghZAdXVpj3k
         lk88CxDYC/07K+MIlMIUmVqDCwzi+igSKpoPU2zNw2trVjgLwthbVvTCN6QW7NrZfSJb
         S3YTc5HqYuz3tu0rF/m6p8gpWScfHt7ufTST7uxqSr/zOvQ8FuhEueDpNAdV2jjh4B+p
         pIAays8Mg6O30uJc2yTgse1/gj9cCOArv7orD1JBsplmFeuKyUmQf5Vawc+5xeaASNWf
         F2jQ==
X-Forwarded-Encrypted: i=1; AL+hErERaSQbwdbhHgIFzYF2Qvi8PFhaOXWqtdiT2P9usDfyuChgJVsZy21SjymqJBx3lJ2INmPloy0CVFstdE3Vh8txaqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T9SVs/hY3FB7swj1EX0w0QXXZsiFxZZVWJD6JOQOEplTzCPTE
	ib5cqivJLTYUq8WRoXUa4vTtkfXhT4i8x/6jcoTPljsuzzT7BOfCRKJ/
X-Gm-Gg: AYBFou1/siNrc2JZzLWBVDOSLQnXfAW1On2Cgj3DGSgbeEIb64mL4UfduqQB6MVLTON
	YbL1+bkDx4t8i8qzqFj1yk/269txFeIkbZRc9sB9Tz9jF5EcHG8fjSUTuRJi2OvRtR9rzfn+LJz
	Qg7YkeqHnJVZRXOinPfqoU/Uc0TDJb20xB21TeBfOOer8n2luLhC1ygX98tt5CvtRCQ/yM3Lr1e
	xaQhdtP31p6RKMNcpriMslHuTQR7Jw5YFY5M8q8hNxo0e4rS50/nNjKFeSRNJJiLFvqRvRc/2hx
	VjiPGS4Ll5uOC6wTIsLa8H6Gd7Iq+NoCQ6EjZVmUdjBTtdNgrYuvNfNUMLP6UtgMAc2Y3+zJWm4
	1ImxYSw2r7Mn57e5auj1s5aYzSiDuPuDsPb3u1MpcypzJSWIlgvMfEZmK9kMXvuQwkfUYzGlJGw
	qOLI3HAczW+6WMkYVBOp+jcbL991iDSj7/9U9uii9tFncf6gCR4lCYmP+UO9nVl/vEWRlBq8AXk
	RSSj5PIyi3mrOYzkVo4h5L65q/mraGUJOwQ3A86Xk8HjLa76IyiZMDIC4ra5KaErgLg+WqvSsL/
	TVIZxuul1C9xcGH035u8Ry8F733rlmNmYWY6IWKx57+kuXlNHMFmLmxuWht8nuE6DBcQbg8liyJ
	UNCDQP88bJoxQ+zlMv40Rg+g40SasLDbhYcL0x7GXaw4o3KO1RSngtVFEEa8l4CRHq+zyGr5FGi
	MCf4J+oBuucIXtFImo7QZpQlxq4BI/4XrvolliIqUQyZLOXmjg6qqJVBmC2BteTo/8Cwt3Nnw6l
	ybu1pap/Nd1SAT5Ow==
X-Received: by 2002:a05:600c:a013:b0:4a3:18ca:806 with SMTP id 5b1f17b1804b1-4ba0234a0b2mr57198205e9.20.1794333970060;
        Tue, 10 Nov 2026 10:06:10 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm6270450f8f.48.2026.11.10.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:06:09 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] bootconfig: Preserve values and key paths during parsing and output
Date: Tue, 10 Nov 2026 19:05:58 +0100
Message-ID: <cover.1794333957.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks again for reviewing and picking up the earlier script fixes.
Here are three fixes for the bootconfig parser and command-line tool,
based on bootconfig/for-next.

The first fixes compact output closing a brace too early when a key has
both a value and a subkey. Reading the output back can turn a.z into z.

The second trims unquoted trailing whitespace at EOF, so adding a final
newline does not change the parsed value. The third keeps accepted values
containing both quote types readable when the tool prints them again.

Each fix has regression coverage. I tested them independently and
together on my Ubuntu machine, building the tool with -Werror and
checking the parser results, compact and list output, command-line
rendering, and test initrd images. The full bootconfig test suite passes
after each patch as well as for the complete series.

The three fixes are independent and can be applied separately.
Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (3):
  tools/bootconfig: Close only opened braces in compact output
  bootconfig: Trim unquoted values at end of file
  tools/bootconfig: Preserve values containing both types of quotes

 lib/bootconfig.c                              |  5 ++--
 tools/bootconfig/main.c                       | 29 ++++++++++---------
 .../samples/exp-good-mixed-kv1.bconf          |  5 ++++
 tools/bootconfig/samples/good-mixed-kv1.bconf |  5 ++++
 tools/bootconfig/test-bootconfig.sh           | 29 +++++++++++++++++++
 5 files changed, 57 insertions(+), 16 deletions(-)


base-commit: 677f83795fdfc25ddc51b665a9111f5ff199f7ca
-- 
2.53.0

