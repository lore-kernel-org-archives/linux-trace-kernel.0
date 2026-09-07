Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222625B082
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761197; cv=none; b=bljc7eiyFkMuTQipCIMNJYgv8C+TC4gQkJVwj4EOK8ueZTDplmtX9ZYo0M135Z6YrMsA5OI+W+16++T5u8T+vmenFrV8Szbf7owASY62HeSGR/wOyCGQ9G+tnKoTRXmRNfEcHzrccp7TnxZM3n9NYo9qkJXWMH/zfHS5/DP5CMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761197; c=relaxed/simple;
	bh=GLaZB2K+gwKIH9wEH+yvU3NKxxa8zul0fZq1t1FUP1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbRJsYRGpLQak52YXwBHKf2dpC8+mput6LJjDLjgS+zOv9Q1lWl633qZP8D9akI+avsG9ql5m2tt3AbXtxI8i2RcE2Kz6IldwitwNBtNOAPnkzntsGXEye7zstCqqM159Ag1OLDV2SQM/Y+4mV84FdEOk/NKjIN81/GnAfug0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovuxdm9k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovuxdm9k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d9201076b3so35887955ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788761195; x=1789365995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nshbquzAgQsD94khPjnUSoSNOBjwfXeTGVGmlFk/VVs=;
        b=ovuxdm9kFcVQZy92sfV8lStYs2N9iA+nmDJo8TV/aR2I2Cm1wEWRRmYgvOP0C7+OPR
         vh092GNWmiBq6oiLM4FDh61Z0cRljF1NZhbDgQ4wlPHZHRSDvQzF3n17R5ajlFHjrr6Z
         NtjPYaXBM+YkLSGks4aiv7qHvLG6lWoP3mAyv2a2xlVsqw6QwSQxRTxMlBSzrWtnzPL0
         bKT3b3zSwwhmo1wV77LC2O3pdMfGCeN+lPoXkTzxkDqzBOSn6NWMNu4QngaoCa0LrXbf
         Z708CKXrqR9n/B2l4zCmmfkAczxjFdwEDD8v5gZ0tWc9eplvjxK93ZixAuhLg/VkCIrw
         4kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788761195; x=1789365995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nshbquzAgQsD94khPjnUSoSNOBjwfXeTGVGmlFk/VVs=;
        b=X88k5wkBGnkMsPLBiC8onbTJWoFNb8gYaCseyJaK9ZhPjje5qiP5vOmw7FejQyboS5
         5BSdDjfpNo8tk18jjOz/D8amOmw2bCKMl75b9MnTnv3BXd2mIoztCvS1l+bjNbCbV3Ia
         vEDnwIHUst4hf3rRwbg8FCiWZ/lP2mMTZRWaSax7fCZYy8Rg7l2NwQq4FLXOAOKnidL/
         T7DNd37XcyUoUoVGZ1W7We/TtW/edwxkXkjZKQN4DstVlCstjTF+EqpaT2UycBzccV1P
         cNggiyfXhXNfVIGB0iH6cxMhB6JlXqIUrxkjM1Om8iRJZRQtP0ovV2Rt3ivfp+vT3g27
         eFzQ==
X-Gm-Message-State: AFuF++n14c8OrqesjI2cleEoU7RkG8wcmzV610gqsGrbg4wpbV0Tv2WT
	7DpxszL+eWLQFYpUEJS9DJ/YKzXSSmxPMbxI2wlnHO2Mzf0s6vZq3Yw=
X-Gm-Gg: AYBFou3isTm3sTT2tzndJa8k45NuNII+CufTDwSZiknNDe0dGR4CuGspqANUXNyThYR
	2x8Xvm+VKBpbmFlgFIL1YPApr/mPxt5j3V9KtXdCJ3eUxpRALC6wNUUzKouh+kX/3GXFTeSkNE4
	krv/ZJjTmPLA3ShfPC49V0FZHSvjdWNB4LrZWo8OkdS1mj8Q07agQe/bINrV1b2nOQJGvcT3jkd
	dPmXKdvDQAan8v9+OP9jrtKLpkYCrYekaNDfAdbi0vGRjENAyHNzpTVqHA1cSydTuu1zrWQwuXx
	9k9aa3hSgoRhckfzWbvbPmH1kHJz//cHSGeRBzGCY3Svx4QwL8P1znRBp10yofXJQieXJcnqFoW
	cI6isZwUlmKPjf8eHxPj7bv2h1Tu8UdouU7pb/7XPs/IG/DfVGpu3L7Zlv8aHhQABFqbUuM0ol9
	iNZIOWBTIv79GsSmjsE/w8werCSRDRrOIuuECNabthSWwz71oXPy1kYiuJ5eD2iQ37zW/6KiUtZ
	zr5gpaUFigsHx80
X-Received: by 2002:a17:903:1a8c:b0:2d8:d4d1:313d with SMTP id d9443c01a7336-2db1267bc0emr294219495ad.20.1788761195085;
        Sun, 06 Sep 2026 23:06:35 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm39485515ad.79.2026.09.06.23.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:06:34 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] tracing: hist: let values keep the percent and graph modifiers
Date: Mon,  7 Sep 2026 15:06:30 +0900
Message-ID: <20260907060630.481398-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907053113.1CED91F00A3A@smtp.kernel.org>
References: <20260907052113.430818-1-donggeunyoo.kernel@gmail.com> <20260907053113.1CED91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 05:31:12AM +0000, sashiko-bot@kernel.org wrote:
> [Critical] Out-of-bounds loop and invalid pointer free in
> tracing_map_destroy_sort_entries when stats allocation fails.

Confirmed, including the reachability the report points at: this patch is
what makes that path live again.

Reproduced with the stats allocation forced to fail, reading the hist file
of a trigger with a .percent value:

  BUG: KASAN: vmalloc-out-of-bounds in tracing_map_destroy_sort_entries+0xa0/0xb0
  Read of size 8 at addr ffffc90000045000 by task init/1
   tracing_map_destroy_sort_entries+0xa0/0xb0
   hist_show+0x6f7/0x1df0
   seq_read_iter+0x2b8/0x1190
   vfs_read+0x176/0xa40

followed by a fatal page fault a few pages further. The registers at the
oops give the bound: the loop's end pointer less the array start, over the
pointer size, is 4294967284, which is -ENOMEM as an unsigned int.

Fix sent, with Cc: stable and a note that it should be applied before this
one:

  https://lore.kernel.org/linux-trace-kernel/20260907060323.480728-1-donggeunyoo.kernel@gmail.com/
