Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777956;
	b=IUEt+Hf0KwYS4l7/fxr8KbM22YXC5KnM964di7RPAC9qs7q93uNtkwHyHDqea1nGAXu+
	 A/9Yg8aVSXLKPOmQSddO0tYEDV1bdybKhwLrCp/tosgzg7Yq0PndmtchQ/sEWmEdt5XVn
	 dXhnpc2nXRTHps7gcu/NFboDf1VTxYgx7yqgx1Rb/SFJ2d+W3jOP/XHB0GAy6DmTCxyRV
	 jqhQhH2OFZN+sZlNQIbME27V04HBCOZ+7cCXH394f311qKvIEW2Fzm2rAQ3Hp0nbopev/
	 oWnEwxp8OG4ONYtV/TWbbAptdUIZboKI7SvfzILkbKd2mEQiqEBjezaMdZJuuw/GdHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tQDrRsMXPh5gzx5RhyL83JNQGl7CwK0fOGMnPQOdIP4=;
	b=wBqWxQ4nbE6IKtek5LA0JZBW7f3nNBHkFi23uHxp53nWsPgGjSKadbXe5D59Fjq6R+KZ
	 e9o4G576YYcS8r7HVBL90q5wCW3mA6vE9ftKKgq1wyISq6b1yBsBCeKr4Uve/u6q3j7Z+
	 DScFB6ph0YlJlRX6SdpPIIY2CDpK4xg47PTxIAdrp0toWOVd4xZDMkDsH5KIc+b6Fm92L
	 iONSxHoa640Qu6kmS+2hgFr898njN6OEGyqVH462i8vYy/IRfnDGkOKHxD93fBLwAoZV+
	 JXs6cR/IefKQCnYOd0DEP6N0Qg4/AgzlwJRHXWwmzjHibAdcH3ZJD0gA7WSo5YNhOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xluKvY5b;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2F606A33E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 07:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F2F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xluKvY5b
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89ff475a152so179261b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777955; x=1794382755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQDrRsMXPh5gzx5RhyL83JNQGl7CwK0fOGMnPQOdIP4=;
        b=xluKvY5bPtzusZiqfAdT8zEx8BcKDYppSVfcc7RpnUwa0jb3I28hrfeY4CSQ0MXPq5
         AivBg7Wl/y99ZZFjguIJczs6dI3rD1dXGdzwQuRAQvbPmWY4EFvzhUc0w4GAhkL+1uJc
         sOHcbkEo0uoWhXi07s2MA9Hy0b22ov9izi7W35R+tCbPyI1x4ck4aZOv2yEcb1F5YFCq
         wdcFZNBI88vcCTDAZG5C7VjQdrlgpoDk7v97mZYV9gBQy8GmIDc9nwm8ue7uKab5i2Dp
         Cq46CgEpOcN2y240XiEiTg69IJ54cALATRgO78h5zqlTwAwZtJqQqvUj1bEaWm2xwica
         +Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777955; x=1794382755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQDrRsMXPh5gzx5RhyL83JNQGl7CwK0fOGMnPQOdIP4=;
        b=Oq1bgeY08diXdEHBtTnlikp2wTCpV+bZMcCHhE2OKkUTCAao/LtF1VnZyWiXSKxHN5
         EBrlT6/lfRN/MVjRbjDoXz20tUmtbyoyDadLtLV7DK1+RCqDYwlp42JerpfSb8HUhO7X
         XwYYiY7wnYgdhOvljVtLZzmqUn7igRXDUXHwgojfha4FZkidAQlWjKlVmpmBUWPWhM3Q
         JceiXdLam3OVsfYHygzKEvxV3LBb3ctiwHEu4RWI6vzBPo+IszHvDimF060uxz0Tjksx
         LykQUYxhPZLf4fvF2iVqzJJ+5UYABgSErqld5e1s1W4HsOZbVlHclQlvsXoGuB2Wa3ey
         t2qQ==
X-Forwarded-Encrypted: i=1; AKwUvByyBZCp0coYmAmxjRca5lnYXSUy6+y7P/0U+okzjIav60ElGDDzIFBzssVn9D5qsKGPKxfVPojJJq3WngR+C+nyNhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ptTrqhVZSbSipe/qexJG7E1sJKfENzA4gJkG/tREjEsy9Pi2t
	ODom5shFQe8WZ1amY/1qweef1d+XXWWUyxZzKjyY86gxF24a3kR7z/PP
X-Gm-Gg: AYBFou0kwGDzwRuvtREpQjqwBnyRNmUcawqqXPsdR5M1UkEFEebkwTttsIDo4OMGvIF
	YkEGvA94WTCP7YZ85cX//3NJw3Vp6TqC+aBEeQiqJEluLWNDoxQztmks5KQH8ilRAkByhFBqW3k
	q83I74HRLSaxaArI35ajl7wM34Xw5EUs1adV6ZWVe1RWpukgOXoUJd5FQFZRQMq7DXp7Wmf8xNx
	A4MTFsvR+RhyARn1qKZuzRbkf8/jrlKdkKa1gaA8tvmjFP2KW8hET6XsWzMHer/9/6jaX2YrrZV
	mUCuS28I2+XMpoSdnPXTzk6GhUYRr3byl05Aw0M8mLrsM27/VT1K+9+W/mANo+KBZ0AWvtP5dKc
	1aROOANyrvwJ+jXT53y98onhj5YmuQ3ci+oXySMeqzvpsyjlR+3jbn/pGQX5Qf2FSbo00Z0+GFI
	4i8zwwVkKmjgtzaw2RhdArihhuHNpAZ5UwGFd2of/+qEgES86PgQZo860FCv54PrkOHhWNOyy00
	HsSkAVsRGFIurqTOAqVwiY7U2ynQP2/Rx1JIJCTXvwpp1YTpkn112Rucws1vP8t5PdowxZea7rK
	6TrrbM6oEOpUol++GYpRvXVquOp2laeKHcyCT/pCUYK0gebaZWTE1PJFSc6uBxg8+QWT3Uy54z1
	KprbUt4JczB3crGMYTu+SB3Q=
X-Received: by 2002:a05:6a00:a0c:b0:881:e737:8213 with SMTP id d2e1a72fcca58-8a9ba806f29mr9927231b3a.7.1793777954738;
        Tue, 03 Nov 2026 23:39:14 -0800 (PST)
Received: from localhost ([103.109.144.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09af91d32sm543783b3a.25.2026.11.03.23.39.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 23:39:14 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zhiqi Zhang <zhiqizhangg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] bootconfig: Fix maximum-depth key export
Date: Wed,  4 Nov 2026 15:37:40 +0800
Message-ID: <20261104073742.21202-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

I found that bootconfig accepts a key with the supported maximum of 16
components but fails to reconstruct its full name. This stops the tool's
list output and prevents the kernel from creating /proc/bootconfig.

Patch 1 moves the capacity check before collecting the next component.
Patch 2 adds a full-output comparison to the existing bootconfig suite,
including a check that 17-component keys are still rejected.

Validation on mainline 05441d697f7f:
- GCC 14.2 and Clang 19.1, -Wall -Werror: 82 tool checks pass each.
- The added test fails before the fix and passes after it. The independent
  nine-case boundary/round-trip matrix changes from 5 pass/4 fail to 9 pass.
- GCC ASan/UBSan: the reproducer and all nine matrix cases pass.
- Real arm64 kernels under QEMU TCG: depth 15 passes before and after;
  depth 16 loses /proc/bootconfig before, and exports the exact key/value
  after. Both kernels use identical configurations and initramfs inputs.
- A full baseline W=1 build succeeds with existing warnings in arm64
  sys.c/traps.c and sched/rt.c; bootconfig has none. The fixed incremental
  kernel build recompiles lib/bootconfig.o and relinks without warnings.

This is a long-standing functional bug, present in the feature's original
commit. Mainline, linux-next and the bootconfig for-next tree retain it;
no matching posted fix was found in the checked public patch records.

I used OpenAI Codex to verify the issue and develop the fix. I reviewed
the changes and wrote and ran the regression tests. Codex also helped
with additional checks of the boundary cases.

Testing is limited to little-endian arm64 with external initramfs
bootconfig; other architectures, embedded/forced bootconfig, allmodconfig
and fault injection have not been verified.

Zhiqi Zhang (2):
  bootconfig: Allow keys with the maximum supported depth
  tools/bootconfig: Test listing keys at the maximum depth

 lib/bootconfig.c                    |  2 +-
 tools/bootconfig/test-bootconfig.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.54.0 (Apple Git-157)

