Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D708632B;
	Tue, 13 Oct 2026 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864607; cv=none; b=DKRWOyLo2SzwXhKOHIZDpOKsl2pJV9VZGsCqP0u6OSue7yxu0V3HL6LQwroyWLY4x+Qro6hAnC5kNoaKMvn2fe/9L5v+0+3+oNjAVAwu3/gkSy064HDEt6C5LCxB0W7t5NTJYzaonfwCTp8nu8xqD5XNSgyOXcnD8gA15TNUIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864607; c=relaxed/simple;
	bh=JCVeLeRVjgvuLq1B0GMpmVqjoBIlBIfPXlCKiI7uBgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=VN6tglj45+6rTmOUe1cNvOrV3xyuzvyxQa+mymV1qkkXZC4ZxQEGCQOaHiBzM1uj1i2MXiSChCCUiyVJwbgCmVkHd71475Yi9lmNPw9W1hWKLOgZlefH2JnMZNIJSri0lUEWvlxv7G8wlyL9jsIvx09mDFUB6qmEciJRu6te8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIDiKkFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIDiKkFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95A91F000FF;
	Tue, 13 Oct 2026 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791864605;
	bh=VL7/TYmyIXsmjc3n3sgkMUej1bqsSqR0QdLErPqK6j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fIDiKkFqO+PiYJrqyIYYvCMsRYSbS5hNAiW47ITQjTysMUO1IzWtLGX4+/Yy/mmXA
	 GFzSwbaopdqA363TwOkIP8DRp7+YGKfY6FgF7pKF1GPFRAaKsyKtwBG8xv0iASOAFL
	 HmKJ+Me6omYQc6wIkCPblfTKr0htiQAN+muDj6Cv0G4jB/mrWDTdGEd7wFNMWs25fp
	 1s6GPOzJNDl3pFF2PjM00y6ysVrqLY+601PB86mp/YG7HAOABcoZIHzz9mgPpXcwgs
	 ma3fDQrqBJcXn4xNInRXGJgm+UnPEWA8IOckiV0X0py0IsIjR7Pyxd4KOBrR9SeeqS
	 TB1yZA1uOcmGQ==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: agordeev@linux.ibm.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH 2/2] ftrace/selftests: Change non-unique test symbol to init_once
Date: Tue, 13 Oct 2026 04:10:03 +0000
X-Mailer: UndineD 0.1
In-Reply-To: <67ac21cd214ec9371276df9ba790e9832cf328d4.1787670777.git.agordeev@linux.ibm.com>
References: cover.1787670777.git.agordeev@linux.ibm.com
 <67ac21cd214ec9371276df9ba790e9832cf328d4.1787670777.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013041004.B95A91F000FF@smtp.kernel.org>

On Tue, 25 Aug 2026 18:58:40 +0200, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> The name_show symbol is not the best choise, because it often
> appears only three times on s390 in kallsyms, with two of them
> having module annotations [mdev] and [i2c_core].
>
> Switch to init_once which has many more duplicate instances
> all in vmlinux, making it a more reliable non-unique symbol
> for testing kprobe registration failure.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Looks good to me. Let me pick this to probes/for-next.

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
