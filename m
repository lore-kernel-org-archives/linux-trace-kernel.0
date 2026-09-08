Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE3274641
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836186; cv=none; b=XndGUuA9qKpgGD296bXg0A9HJ9ejsIqocHjTJOC2Y4DifpuvvBSYj9obvLLvOIZBWwKwQmD3sP1m4uIywmYUR6OrPc12iL0oDT5/XFA6tu9meTKJ5dmtJIw2+CGxqwWYhJXLLFIHsiYkVrvw4soh9H7msmeY9pn4qsy/P1uqmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836186; c=relaxed/simple;
	bh=nh2azw4Q09y+V/LEQu8pCrIHmotw2s9BlnECGdIZ6Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlRQsDsfUvkXw9FNziZopsqDqTiTk6bLJRT48zP4tfXRsa0P6RN+O6lPdnOTk8g2XpALRcyK8nn4sWzwiJXrAdjv/bblyU5zQuYgogQeWVAghPVAMUJVC/EJOXkJsJrk9k1cslD+IiJAoWSPRrzHOpwzCrFgQOW98Qca5NXH12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OerdfL3Y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OerdfL3Y"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4170552a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788836185; x=1789440985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ej1AYuaJ6I913RYzOv3nrsx0ow2YNcqJVwdQB6kart8=;
        b=OerdfL3YcYBRw4G9U5biJhwUtmNLnCZJaaFNuSDNLTibHyCNuJ8L6+9p8Ryh9TUNGP
         o9C7FsuLtmUPW/PkMyklTgw+3Xbq0mvEfFejkrLyxupDlu372xniUrUwp7cHLrbs/fQg
         FLdNP+1Wfkv09OvipEKS4Ft9zxg/i6fl22dSbeqG1qzfcZPPEJ76S/65zJrKoTkKdN14
         8BvYdvH28+J6P7QMVWrsG62pxoaCMoJVz3jjjnQXu7X+qgO5ErNP8djXSHB4NbiDMVgg
         mkgsoBzB2Jy5+04RFVbzK+BAscPh3UVHuF5kAWksUeU1llKqwU+kcoC9kX5BLASoy3Nr
         ZRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836185; x=1789440985;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ej1AYuaJ6I913RYzOv3nrsx0ow2YNcqJVwdQB6kart8=;
        b=oPLlrCZKgvSksu4eNjesHt/rEcO865R21Fy3oFgpFUl5sgFLOJnykT6IhpaXnLusJ5
         hAocJ91XL018/D+cwebwcUSWo47u+OfsZmMlVkxtPKsFOmatkqZgZS7MAPDycMG5OV4j
         zkKhvNX6mP5OV+BZBZwAgKnklPqPRpNLSJsSNNDI+DcVLTxfAFV6pyjT8WgnAaYiDT3K
         C7DLRZ8mv2N875sY/ohS6/z7KKpHG2mvyTfgiMISJHM8Y/cN9I/mSO5lB2xoMmiaT+ND
         M2hNijpD/VfjlZs+2GwBMbdVCAbQ8FoQR5IzWaNp8baUbBm7bfhyCi16muoExIN+bI69
         2Zrw==
X-Forwarded-Encrypted: i=1; AKwUvBykbD/SezhT1MyLvTC5y3jepDDF+owtf2e4Tx3b16gN7rnlFOk9aDH7G+/ufHRm2Da6THUCBQFsU9iOdGVUvSUTSRs=@vger.kernel.org
X-Gm-Message-State: AFuF++lUjeDtCUAyi+/tkyRfiPtADzTNsiUeHsXnZkkEdAxarEYx+Eso
	qkP82csbcUrFJpHZSGde7ChPeMOHESmEOJMXjh9LdBEeHiL3SbBIBFVZ
X-Gm-Gg: AYBFou1eoIhTPeceY+8zKWIlMCKjw8viw2SWKbBkjn51PPV+mtoK61bMCuNBJ/hu7cd
	1Vcs91rrLXqG5VYaXgpWg93NK+P1smLfoun51rQAoALIdQOVJ+b/bc22dItMiX/S/qlN1fMUb8M
	xWs4OdtW/CHb22zilGic80qUrWvcu4c9W6Ua06UC5bzDzLs5O16ynImcsJSJfCEt+P8U8Y9H2c1
	kx92R67OaYU1awKzj9qKo6CDWGu8wYBvsCj6Nf2M3Sqn7CfM/2eQZsMVcZSs5ajyferLcdlyu2v
	+sHT9Dro0XtR/kVX55cbK9idy5CcUSh6Ea4hcpQYkqHjJQUPn8DZPXdLtqrgwZr5jLKUir0Msxk
	3Dy3fESve6eCf5pieSR8PK83ixHNpCHqALH7zLydYyxxxqZiApeV5PtQd8Z/+omx9vLe5GcCHyd
	ARoyFxD2Yb1O14bS8ZvBMYjM/+PjT5zuMS7G3xfp6J6nP7G888Ojz3CpTaiXXTGwtkzQeA+LBN2
	ng=
X-Received: by 2002:a17:90b:52c4:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-39b260d3375mr39542125a91.2.1788836184768;
        Mon, 07 Sep 2026 19:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3fb3:b562:896c:1ac7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26155324sm22925971a91.17.2026.09.07.19.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 19:56:22 -0700 (PDT)
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
Subject: Re: [RFC PATCH v6 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Tue,  8 Sep 2026 10:55:51 +0800
Message-Id: <20260908025551.4155877-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908101509.5ca094dacc96053236f7d2f3@kernel.org>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com> <20260908101509.5ca094dacc96053236f7d2f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 10:15:09 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> BTW, to make it easier for review, can you split the patches in
> several parts? For example, start from a minimum basic functionality
> (just internal stackmap, seq_read, and reset), use it from tracing,
> add stat interface, binary interface, and documents, tools, selftests.
> This makes the series in at least 7 patches, but nicer to focus on
> one thing for each patch.

Agreed, and the split points you list match where the current patches
are doing several things at once. v7 will follow that structure:

   1. internal stackmap: table, element pool, get_id(), create/destroy
   2. text seq_file export and reset
   3. use it from the ftrace stack recording path
   4. stat interface
   5. binary interface
   6. ftrace_stackmap.bits= kernel parameter
   7. documentation
   8. userspace parser
   9. selftest: basic functionality
  10. selftest: reset semantics and binary ABI header
  11. selftest: top-level instance gating

Each patch compiles on its own and does not leave unused helpers or
tracefs files whose backing code has not been added yet. Patches 4 and
5 also carry the stat locking fix and the binary export rework from
your comments on 1/3, so those interfaces arrive in the shape you
asked for rather than being split first and fixed afterwards.

> The patch description is a key area to focus on; if the explanation
> proceeds by saying "add Foo, then add Bar, and so on," those changes
> should likely be split into multiple patches.

That test also flags the current 1/3 and 3/3 accurately. Both of their
descriptions are lists of independent additions, which is why they grew
to 949 and 614 lines. I will use it as the check when writing the v7
descriptions: if a description needs a bullet list of additions, the
patch is still too coarse.

Pengfei
