Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B439733E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677954; cv=none; b=qzNcNIDlJCxMahLiCiGgYPjJ30WrdAbN+B4qcvQjlIMUkEUHGE/H04lwlxe4nVq07Qi6b38ah8WhrfNMj+DKhd71Z8D/PHQ/iOxjVXg5G/HBh5jvxLko+CJctgT9MMqkW0tq7z1e3EHnKM27RRb6L1+9ppa+SpoOIVP7/eo3E6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677954; c=relaxed/simple;
	bh=nmsAQww9dgWl/W5T2Mjb95A7HHO+Y3Vn0GUTxAd2cV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU2aji/MrwepFjV4U0QuDPiuLdHceWdl13+cnZoMMSUz1CxuLEUm7mlJ5m36k4oP9tiUip2ysTnABbtRBobFivx+Rs6RfB3S0NZS8fYoVCGkAJtEFFYIH8SVceLMhczy1jczLh4QVf1Upy3qEp6TE579P0oLzJZm80Ddelp8JZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdlCVU3M; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdlCVU3M"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2269362a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788677953; x=1789282753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmsAQww9dgWl/W5T2Mjb95A7HHO+Y3Vn0GUTxAd2cV4=;
        b=AdlCVU3MYOgXK3/IvMbNZxahp9pbp0ZYAH6KcmBJPbUu4tp5FTll4wiKnl+lV5Edw5
         DcuMlOknZfQ2ID6WF2UttBtoU3wdysEcHAQ6tvCr3GryUOHDPX0mF59ZsxsYqTFAi7cb
         XDx0dUq7gTffiTzRIhPK3Ga5uxWsY2tIMFVdzpmhgOmM2BHc1mcYjbKoJNVNbC3gCEcu
         pUNw6YfL0dqCMGgZhYqO+E6KGHebg91rMOixtmJf3WHMirhNNki9PJJmtgAWaH7sxWBS
         m3a0ogbbkmtR2uLAOUYGUOL8ZDIDrOKytrlaxAs1pnewMJfptgvJKUSjpEdgtCrgHRJ7
         zMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677953; x=1789282753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmsAQww9dgWl/W5T2Mjb95A7HHO+Y3Vn0GUTxAd2cV4=;
        b=ADL1pm790U1OY1eNjv4sFrfAWXrV0p6XGquwJmhVkfLkmDFB8b8UKvlrakYt2JS7eA
         1A0+pZME2v//wyexKZY2YCa1+r7WX2OrJk3NoatzLZpfEhe/zJNrWa5aVyGTsIpkGzPR
         LclCRkY2FhzuqrkBp8j6PbVVqtAzS+T0WWQUbObHDfDVA5xrqi3IJ4G10Ftz0Jj+OFs4
         +f9U7a88KOOhmS3FdHnKKFtAEcWzcQ8GRqNGiKhP9bZHiWpr0+VYqVSRQVzCIAUE1bA4
         nkuMCyYmY6H7xYTc8xtrIT2fzGUr9mwIfB7+lQ02oxpkUGRGGFA7o0x7SOcOu6y86j9K
         GYtA==
X-Forwarded-Encrypted: i=1; AKwUvByMmv5VvYIdFKDmBfXB6rtga2nujepvZ7Was/bTZmIbaNz04y37X81bMAnyI5duMvr1e3NSDFNJpIWlxzlA1XWSioc=@vger.kernel.org
X-Gm-Message-State: AFuF++mnNFHHx0iFBa5IgfqMO84dmVMTsX7zJl5WPpR8fs/gFyDoH9El
	P3s7wPHoG228ZeQC6a0cJfc8B9jIxJ3a63ljoJD3bFhZyozIyRLKBuQ=
X-Gm-Gg: AYBFou1HPenSCRYoKMNdmP0aDM9fGgmffAS+28aHZBg3im5jZq/U4B5hkjFNUlLYkhi
	Ky+tu0j+uCB5NQ4lymw9Ge6PW1Vva2aUIIImx2CJuKQuzIHdCZHRfmCxeTM+VGPFxFsuKeSFK/3
	6fFD5D+SVf+3linCSnWZB+0+K0jMEyC8LjVpl3SnKkQuCo7wQCj+dKeOm4wbjmbI3mQU3o0VkLJ
	zCAqFElReXkymYzl8nRkBDYB5eSXLjS9EmeAfMOtquxZ/xrddIQA4OdveXpGBAJEcrvd8WaXOy3
	p7ohJ9cR18FLpncRwpgB65lyZKssq1pClLuM1gSk4qQz7S9o5wa/iXmnwGwpzrXfmoOolAeMki/
	rpfcn6DdUYl9WhwDK7VGm5/WSugfp1MNcIZY4zMXWQvPiMDrVxTl6oNuDRMpjHQrpKpgH/1a1Yl
	oEz4PlbZVJBteaolVJtb5yAoGIy9JKAry2nx3RGQvtJYIAtNA/Co1KmA1Guh7WjJ8IVBHvYuTdD
	u8MkSw2YXk4jMbN6BeuBSffZAj3
X-Received: by 2002:a17:90b:39a7:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-39b26125efemr23047016a91.10.1788677952877;
        Sat, 05 Sep 2026 23:59:12 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fe843sm13604739a91.10.2026.09.05.23.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:59:12 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] function_graph: Use the saved entry's size when reprinting it
Date: Sun,  6 Sep 2026 15:59:07 +0900
Message-ID: <20260906065907.1495913-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906040248.3D46F1F00A3A@smtp.kernel.org>
References: <20260906034406.1335316-1-donggeunyoo.kernel@gmail.com> <20260906040248.3D46F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 06, 2026 at 04:02:47AM +0000, sashiko-bot@kernel.org wrote:
> - [High] This problem wasn't introduced by this patch, but state
> desynchronization when reprinting a previously failed trace entry causes
> the current entry in the ring buffer to be incorrectly consumed and
> permanently dropped.

print_graph_entry() does not always return TRACE_TYPE_HANDLED.
print_graph_entry_nested() returns TRACE_TYPE_NO_CONSUME, for the reason
given in the comment above it, so the quoted branch is not reached in the
nested case.

For a leaf, print_graph_entry_leaf() has printed the entry and its return
as one line, so the entry left at the head has already been shown and
consuming it is correct, as it is on the normal path. The iter->cpu != cpu
test is what separates the two: on another CPU the head is not the return
of the pair just reprinted, so it is left alone and ignore is set for it
instead.

The other two are pre-existing, and I looked at both while working on this
patch. get_return_for_leaf() returning at !event has already consumed the
entry, so failing there leaves data->failed set over a copy from an earlier
pass. I saw that once in about 30000 replays but could not pin any output
on it, so I have not sent a fix; say the word if you would rather have one
on the reachability argument alone. The static on ret in
print_graph_entry() has no reason to be there, though I found nothing that
misbehaves.

Thanks,
Donggeun
