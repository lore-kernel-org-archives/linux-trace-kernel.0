Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DC4AF157
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441752; cv=none; b=KNnz5gotXcSiheJWGpacQieFCTURGM/Voqy/XOX9sOD0Q8QhzBJGXkqBnPof6xI7E56JNXoH1C6WWRSx6Kf513Kjk4PhlJ/KFpeLGC5ncJp4AgpMCF6bIHH2rmbeudyyDaZ5QzrI2udBU8UQubXcTPMrb6zetMvI3XmuMdvZ+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441752; c=relaxed/simple;
	bh=fBeMkFaC1Cs7R3UZ2FEIJChYmhbI/KTvKfsZ3VllDtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv+XQ9xHp3uQCsMl1dP1CFI1Jbbh+Nvd7lp0aKPV23IlJayYlEfbFfa/ERUivBe9bG9XgNo/yqy+Q7cfLj8TpbLjRRZB0DtwHsIJRWzTj0zwGb1OLKQkgx+T/Ba44u/ntvfhXp6o0bXVpRU646TDk+3HQeNKob2RRbvuon/7R9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqZFWulg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqZFWulg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2620895a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441733; x=1789046533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fBeMkFaC1Cs7R3UZ2FEIJChYmhbI/KTvKfsZ3VllDtQ=;
        b=SqZFWulg7KvcXlqEnA4Lw6rZd480mwzZMQ5bt05xAUmms0+5HvMJwskTIzh377Em2R
         2cdJgjV/FAUdd0FhH3G7v4uJcWoo3R8fJjPKrJ6U121eVEBGDyhkkK/bwG5B6DdO3yXx
         mCuX59Nb+IW0esKBCg1ccJ/Kq4B6YLt5dpbxahhWG876Q/biKids7bDiP39jU0xzz5L5
         q35LThB18mcFz1TcyQTjq0TQOZHTRZDgqkKxJDnSlbJmC/naWFxpBGLzv/fWr7WW+LFk
         BWZ/omuQQ/Vmypxl4mkYfLb5Swg0VGDFEAz7PSFsRbpPp6S24JD0seJBrsvl9iDqy/mf
         ++jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441733; x=1789046533;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fBeMkFaC1Cs7R3UZ2FEIJChYmhbI/KTvKfsZ3VllDtQ=;
        b=s2FCpfbOOBcLQziDuOoHjhoHn6l9+tA/EbRARR3O7YZ6amSdlywXVy7h9SqX89BMPd
         abqkt+rnCpRj2qlkaOmUbE3dlXcy34W7M9mVYQekhTePS2gjmI8pgh09vV5LBnAgfExI
         ftp36+UiGA44pRjgPgSQM84ORRgFI+kVOntI9Z/B1daErXMzBVRsJTdBO6L4UcTzvU/B
         OnLlCHhzKx9MPbpQvpDJOUcZlloFOFE7vyja9bw4nO+owdZTJYSzASN+VUWSg1sKPXpL
         Dp1cpoFUixufZwV0pfQnhW5diM49p+7qrKLkdxGQe9mscs3QT+AmwDrXrly/8kfllJBt
         oS0w==
X-Forwarded-Encrypted: i=1; AKwUvBy3E3W19+htR272Xqqq+lZbnqiwy8buZ7WX6Db3jT4rV5MDYInivOXEHVY5Pt+v/uqMpL8L9jvE1mhLCRT6kQ+O9Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++ljXbWa9NfbAtCTaM8tTWhLmkzgC00p/AJLo01l4StFwuixTqAL
	5frpTmbdqPwJDOkEhtZLDvNZqX0jjKaZ+ZhYuF26m+le7uocDfXckTIW
X-Gm-Gg: AYBFou187Xems2q5wev6Yv48zJMzX6a+de9Vi9a3A+xe4VYqN1CKVnbbClUOrV/j7MM
	Qq7HtD1M4ONJCxLy13+bowEuXuW5a24VOIS2g7c+7d0VgOP6ewG8T6dOIQYqs+h4qboCUfdIiDq
	uc/ioyMI27uJaOF6Zgr8BlQThi/zqTAhctTQ2RJbWiISpcsuY5rZFczTU5No20W8X1R9eZ+ex9j
	XU2PRZW/2ODY2BCdgXBTTr2extUEAkX+OJnzB9FmRnlSECsTfUI1VOmyqy6PYPecrRvKXabJo19
	zryRBhLwuYm30Y+IU+KyOayEG1Heyqf3uOQ6oNFw4lJIGtTIl79kmZ3PSEwzolAXBCwRxc36Jkc
	6pCdza+75NuBxAkaRTtG/ZT5sIR51+84uWpkodf7xivcJ3qbgkvUhSHyxVemocu9MTKEUedrbo2
	t7pFgEHT9vhSm7Uw63L1rpIRTeTrIm7aIVdonxWWn2pEDgfK/qWic/nQowxieNobO0HButXevAT
	3Q=
X-Received: by 2002:a17:90b:2808:b0:398:9be5:b417 with SMTP id 98e67ed59e1d1-39aee1c63b1mr20007782a91.18.1788441732646;
        Thu, 03 Sep 2026 06:22:12 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm5407729a91.0.2026.09.03.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:22:11 -0700 (PDT)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/3] trace: integrate stackmap into ftrace stack recording path
Date: Thu,  3 Sep 2026 21:21:50 +0800
Message-Id: <20260903132150.253372-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902065433.2D6361F000E9@smtp.kernel.org>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com> <20260902064242.28606-3-lipengfei28@xiaomi.com> <20260902065433.2D6361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 06:54:32 +0000 sashiko-bot@kernel.org wrote:
> Could the commit message be updated to reflect that the buffers are not
> cleared?

> Does this code unnecessarily export tracing_reset_all_cpus() outside of
> trace.c?

Both are real. Fixed in v6.

The commit message was left over from the stricter reset design that
was dropped in favour of map-only reset. It no longer claims the
trace_array buffers are cleared. ftrace_stackmap_create() still takes
the owning trace_array, but for a different reason: the text and
binary exports run stack addresses through trace_adjust_address().

The export was indeed dead. With the ring-buffer clear gone,
tracing_reset_all_cpus() has no caller outside trace.c, so v6 restores
it to a private static helper and removes the declaration from
trace.h.

Pengfei
