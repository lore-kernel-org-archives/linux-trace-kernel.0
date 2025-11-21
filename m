Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607462C158E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747124; cv=none; b=BYgoX6wtbw8v6+ReFL08Bfk0XUR0GWYRIgfayyzZwue5g4gDfobC40748bXronak9NrrZSasRbkTm5SHEu4pKjxh69j7jb4sz2+QXi6ChzhW+FreHdLJ8BIWJT00YCfM6pw8SzC3b7FNqxIedMVGplHwwE4/DMpue+XQlvaTHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747124; c=relaxed/simple;
	bh=1wRpDQF+PYc0CZ0e9+rmq3caZaUgiXV5uRUf2X8d4Ew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=pMuLMtRho0r3Njlk2Ce8pySbL9ZR6XegG4mgWWbR2oA+QqvXtyB8RLR+oV+a6/x2+BuoeEqJ1EZ/32LtryHQt2xd3jCi7nJT4aYaFhJWrrMXIyklmNULBlGWSWJLK+PiYEnS76WaGSd4c7KAATM2qeE3ckyyy4bHo17lLyLiS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB5uvylf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB5uvylf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763747121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iPUxsCB68OtlQ4ZU2Anvk/LjkstuSN+yLG3TCw1aX4g=;
	b=GB5uvylfJDLOI3GZoiLY2NX6GeQQYX08BKy8GBdH+xFN9SnND7OjvCzaoepNAcYmvh3uS7
	R7tKhgVC9Ut/ixDfx23Wh+R1y25q7QoGmYWNhjkqXe2PvTpT7p4cZgynMta00j1/6+UOrQ
	wZBgQJbfW8GwtQuKgsssI4cWJKMAftM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-vIIRAIUtPWOmQCNsaQ1Sxg-1; Fri, 21 Nov 2025 12:45:20 -0500
X-MC-Unique: vIIRAIUtPWOmQCNsaQ1Sxg-1
X-Mimecast-MFC-AGG-ID: vIIRAIUtPWOmQCNsaQ1Sxg_1763747119
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so16068545e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747119; x=1764351919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPUxsCB68OtlQ4ZU2Anvk/LjkstuSN+yLG3TCw1aX4g=;
        b=O9HkWcPBV0knw3DWP9k2M7U/cfByLlCAnmzoIgYv82S0GPOTD9kqS7XmO3U7NKN1pF
         oGhdoZ4KFOZlUrdVt454mimKFI3Un21yXsD/G1lPgyUBV51IVNGID1/aTQl15bH2lp98
         GCLhl1PvmB2Qhij2/H5uhzr8dMOUYTvof2hGeN+AOI3UAI3WBSgOh2jStbkb6lcD1JHc
         uopVejn0uyRuY2LeP8DberaazLSh/DxtulCKFHe13GlRCwi8YeB6+7e2Y2r2YtgfsUi0
         aVeVOUhvBurG+tGXxJPD2erWVFGEEIFYa6tA0MuT7bFw63wcLRNeYXW+IjMig8FiW46B
         Izbw==
X-Forwarded-Encrypted: i=1; AJvYcCWPBzyMLtCga4TpALHQx/SZZGb32aW5SUt0yZ21cv2C+knBkMshunvUg95QEeOWu1xb/WFMmkwvpr+IHzPziOOHYcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1nCMfe0lfLpVPch+TAsJ4heRsi4FEU6nt4uYV2Dhyq01+tOA
	PsV0+5b2fjo10GRDRjqs0Q4WyHyJaAmwTEwXLZQjpYBz1sAxjF1Yzu8AbeLK91CJXm5vuPhMX2L
	fHbVbjqhaNelHObeLinAFhlRz74PSmQic5cV4zjGPcW5pXANCCodo0w8ZgAafVPbKSAwZw+C3Hg
	==
X-Gm-Gg: ASbGncsxn/zgd9/CUVO85i2LZkvjyqJigFAjSgzcR7Uw4lHAi2nZ/sj1FG5lqIT6eAl
	6Ksr2zaLHAwRKFxUMndDeuiFd5/R6VYXsXLmkTW0FR9nvJvGsHs/PsJRfhLmiYDy6Vx4uR4huKh
	HawD3+uboUohNOjabWMLXNVehYeuIAkcWq8zlZN/38tNPr3yIHEqbKM9Ohwb82SLrewSnsnk9cn
	0VcAMycwJlEVIJHabX0KjRZAKHFVd+/yUjKtEhjK0pbJYvL/AYtVF+9nvRYCn4klNpXiQYLMzes
	rtlI4+xF4VE7DzPCSX0j/21d94eRr7g8fLD6nZ8OCngnMajiZCDQ+mCOBXv1H7BoY3Mb1NkjmBJ
	C6czN0S27DZ8E2uqIC0LkZmYL
X-Received: by 2002:a05:600c:4e87:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477c01ebc76mr34703235e9.30.1763747118949;
        Fri, 21 Nov 2025 09:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzqsK/8czIQV9eJ6zCC2tqD4f0JD1dgzV6/tliXXqCBq0SC0Gw7XP+mw8HTIxPxE72VIDirA==
X-Received: by 2002:a05:600c:4e87:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477c01ebc76mr34702975e9.30.1763747118517;
        Fri, 21 Nov 2025 09:45:18 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm11529567f8f.0.2025.11.21.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:45:18 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] tools/rtla: Consolidate common command line options
Date: Fri, 21 Nov 2025 19:44:56 +0200
Message-ID: <20251121174504.519230-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WvbYvnET6ZvB3Y6eqlbscNW56Vz-AHSB2-cTvL8LuiM_1763747119
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Argument parsing functions are the longest functions of the project:

lizard --warnings_only --sort nloc -L100 | head -n 4
./src/timerlat_hist.c:766: warning: timerlat_hist_parse_args has 247 NLOC, 76 CCN, 1579 token, 1 PARAM, 287 length, 0 ND
./src/timerlat_top.c:538: warning: timerlat_top_parse_args has 217 NLOC, 64 CCN, 1338 token, 2 PARAM, 262 length, 0 ND
./src/osnoise_hist.c:469: warning: osnoise_hist_parse_args has 195 NLOC, 56 CCN, 1225 token, 1 PARAM, 216 length, 0 ND
./src/osnoise_top.c:322: warning: osnoise_top_parse_args has 169 NLOC, 46 CCN, 1019 token, 2 PARAM, 191 length, 0 ND

Moreover, they contain a lot of duplicate code and growing.

Refactor these functions to reduce code duplication.

Benefits:
- Single implementation for common options
- Easier maintenance and consistent behavior

Costa Shulyupin (8):
  tools/rtla: Add common_parse_options()
  tools/rtla: Consolidate -c/--cpus option parsing
  tools/rtla: Consolidate -C/--cgroup option parsing
  tools/rtla: Consolidate -D/--debug option parsing
  tools/rtla: Consolidate -d/--duration option parsing
  tools/rtla: Consolidate -e/--event option parsing
  tools/rtla: Consolidate -P/--priority option parsing
  tools/rtla: Consolidate -H/--house-keeping option parsing

 tools/tracing/rtla/src/common.c        | 78 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  | 53 ++---------------
 tools/tracing/rtla/src/osnoise_top.c   | 53 ++---------------
 tools/tracing/rtla/src/timerlat_hist.c | 53 ++---------------
 tools/tracing/rtla/src/timerlat_top.c  | 52 ++---------------
 6 files changed, 95 insertions(+), 195 deletions(-)

-- 
2.51.1

