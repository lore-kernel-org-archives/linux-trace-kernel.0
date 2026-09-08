Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3E28DB54
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837003; cv=none; b=axnRRUx1R0v5Kcv4Rrbjmt59vt1cbRn14v65o/UHFBx/DZIbBe+5dr/Hw64OnjqWmvj/Q0XpJtCfqx1bcZlhFUG7TIXhkbW1CqrxGN1hm9z1gb1QkyZ+wmR7M8Gg4NC7yiDebm8GfZngrnbuUHTbNHyqH/ZTAfbeU4few2fTdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837003; c=relaxed/simple;
	bh=NIZ40nNzsbeeL8cdyy6ZKPpOyXaqocZlHwIU4WgHUck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXBNqRpaa9PtIyc7Ki2zrycR/BeJfFgp+08J+62svJXE85idcHM9YK2eUJ2IJZ2DX7Rsz4MAZlVDzyAnaYFIpMXW3Z4T5JVimNiIL538u3PLvAovjIgAv8oOoBMp9x7JCMlo80jdjG3Mg8t44LQKflUI5OZMZP3GvtQzX2qfU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/NFaiyt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/NFaiyt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d8f265cbe6so31228305ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 20:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788837001; x=1789441801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5udmBuXlTT1GwJow6bPNXuqCwSBhZgjyh+ECHMZW2WA=;
        b=Q/NFaiyt0R/bL+cvpQ0D5PaxfS/njeOH1Jqycs9RrJj65O63iB9yBlZxCETd+uttaW
         f6lKbbKrdeiA/eTJbydj97Bhc55S4wzidP/cChT4D8/7jkviHA7VAbxwh+YwWxQmXH+z
         xQk/XsGiOplS+2Q5NJqQJESnKC8cErb8IAsFcPegb8lfwhflYkFPSzGQ+5GQn/BujXFe
         TPOId7vkUHzeKeaBdLuKranmAx4HjcZej7Y0KtAKNKaW2xyRtmg0bMaB/JmFHZddFHrx
         zakmmlPaN1TXnhJxj8zo8s1u/l2tVlb7xwt2Re6RVZb1nLIQ33+Bc464g4YjAFntW5Nn
         HiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788837001; x=1789441801;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5udmBuXlTT1GwJow6bPNXuqCwSBhZgjyh+ECHMZW2WA=;
        b=aaVyH14nO6Blgjy3lY/5b3ZbzbJdYl1HW2pGBOLmNOMVorq0Q59ggw6viWE58Mx+Zm
         1mJIwdoZba7qXEcS8AFORJXhqmZ1xzI7pKra0coV5qnjzcLyNfT7ZmfxO3q5Aag7KV/S
         Xxjb3pXlG//1ueYXDLNQiX2EeE0SEj4lo2e+KRHF4s8EC0GBKgS/zmHENCtEtkn470pu
         K5Jv+FDicWCTu7X0WV7ZVvyEvCvgYE/mgOO1xjgENgReiD4rEtiAtHbz8Li8mrbEVq9A
         3rqwY651rKOl19x2ILfTVIJQcZi7wT8HDsI/cXLD9pE9RvhF9V3s+02nwipX9BAQCDT2
         NJfw==
X-Forwarded-Encrypted: i=1; AKwUvBz8oIm/p469M8TmC+BWyw/+jkBwUXScw6v7lReTY3b3JEuvjCZ31FfMBre1K+8NrQKrZZHFk8lhMEbgY4KqigTb4N0=@vger.kernel.org
X-Gm-Message-State: AFuF++lSbnAoxX9XGEfN48jk5coNV3cUdHgPR4TH6cr+XCo8ON3jFdms
	HjvcRLCktwLQaczxgwd8IW7p2ezfvXC52Es9U/40OoNe64XsvvEIG0k1xCgFMA==
X-Gm-Gg: AYBFou29BR2iRLfN2lxGNLN1pnmqxelXfD4l87W4oLUgZxRTUg8vYTNuHa0c9CBWsHo
	FN8Ui0YovzWvEOyhlZXABU7G/Bubfl1Kp86IxI/+6+F/iKf6XS2XjQHDB4w5gKgWkShV5WlUa2N
	Ukv5zHyTyrf9FFwJxidAIziMo+5wTG1y8Ed5X0a8KS1oG5nZkqQIoDMmn/HF2Q1aygLOAwRDibD
	FeWmTeuVeFz8w1P/43pjWqnhPRmbFl0Rb4bOoFKQ14ubU8nvG8VuzJOE+CXSstljs8oto00fWlu
	xBMGqsAYZAwoPOYGabL6bLx+M4GeBWCBw9MKXAlZV/HwKLFuu5mmS6q3vko7vvnAFQhII5HE+Wc
	iJKuVkjEdzK2ND6wDiMsRIErw+ytXWKkjyrlA+k4eEWwk9gtZeGZcomCnseWH79cxbyIFGeMybW
	4FW2nbhuatziOA+KA2cWiPvhNC62EW9fivjLoBuV9u/t1bt9eLKlzcY0XFuIzkZ0xcxptiArEfg
	0s=
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2db126d6e31mr377723085ad.13.1788837000864;
        Mon, 07 Sep 2026 20:10:00 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3fb3:b562:896c:1ac7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149cb603sm51255985ad.68.2026.09.07.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:09:59 -0700 (PDT)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Tue,  8 Sep 2026 11:09:38 +0800
Message-Id: <20260908030938.14046-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908103514.a1c61f51b84b8d67d6f0f511@kernel.org>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com> <20260903132409.270195-4-lipengfei28@xiaomi.com> <20260908103514.a1c61f51b84b8d67d6f0f511@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 10:35:14 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> Could you decouple tools/docs/tests in independent patches?

Yes. v7 splits this patch into the documentation, the userspace parser,
and the tests, each on its own.

> If each test has this volume description, it is enough to split those
> tests in independent patches.

Fair point -- the three tests cover unrelated properties and each needed
its own paragraph, which is the same signal you mentioned on the cover.
They become three patches in v7:

  - basic functionality: stack_id events are produced and the map fills
  - reset semantics: the map is cleared while the ring buffer is not,
    plus the binary ABI header check
  - instance gating: a secondary instance exposes neither the option
    nor the stack_map* nodes, and writing the option there is rejected

Each lands after the interface it exercises, so no test references a
tracefs file that does not exist yet at that point in the series. The
reset test's ABI header check follows the binary export patch, which is
being reworked to a streaming seq_file export per your comment on 1/3,
so the check will match the final header layout.

> > +    with open(args.file, 'rb') as f:
> > +        data = f.read()
>
> nit: Can this support input from stdin? If we use this on android,
> user may want to do:
>
> adb shell cat /sys/.../stack_map_bin | python3 stackmap_dump.py

Good use case, and it is the common one on Android where pulling the
file first is an extra step. v7 makes the path argument optional and
reads sys.stdin.buffer when it is omitted or given as '-', so both

  adb shell cat /sys/.../stack_map_bin | stackmap_dump.py
  stackmap_dump.py /tmp/stack_map.bin

work. Reading from a pipe also suits the streaming export better than
the current stat-and-read pattern.

Pengfei
