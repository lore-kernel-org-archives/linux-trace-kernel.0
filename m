Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2241D4E9;
	Mon,  6 Jul 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341588; cv=none; b=hrYUdo6u5p71N9yak+7vAEtIl5I/D0YpGxRC2nm2LDtoQk95Z6krSqMQnjDKstgQU3uT4tFfuqT7OnScPs2ZI/cCIeI/mULJIayLqUNOxzXgbAu/KMK2tPDo1MzeRXLXw0ebVgWSp+SLvVjfhheyIyz32ChoqgvqJ3+qhnGZiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341588; c=relaxed/simple;
	bh=yy1WvoAT1cjd5MpPtTSODAFsNYQP89OHsS3LN6EvePY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fw55+9bU1g9Vn8/pX1sMgSb1IkGqPyIawUWuzAPg24eKY8QYPNxdUUScAGPsIYc+fQuqcskoRWNriLyk0DujFfq/FoI4/AO6p2blqIQd1J6UyqLNaLIIUr5NT1kzHwRbANeBnkK4qaZhBS5Fm0bDUh7beLGmRdfTCVKBdL6SB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgD67hHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgD67hHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D171F00A3A;
	Mon,  6 Jul 2026 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341587;
	bh=7bO5p/Zdyq064cbGGZAF80iwFJGqWOUQROWALYg9xvM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LgD67hHnLJZF+pPnse+savXDaYqzIUefB830hTU/LhNv/JJKYjq2b2tgw0eh3TBE2
	 6tqD27GwiCce1g/0Bnpo3qQ7rODDzVuDDZPswWfS5O8ZWwGnnr/Odsj+4P6TU9l0H0
	 12jtfXzu+WxLla7bVFw61AdMewMT+cUf+H1a/andXeDpKFE9diRLuE3eMlRjytqNgk
	 /sTLGqsjOCDHjBIbYPCE0jEBFc0tgO6VRzmoXvyUQnNMx40uh6PqcBViItQap3tcD7
	 nm8Fk4dt/jxGeqOM/rJaW0DC6tielhqa+Hjyj+i+sTGRDM3p+O1LeXPexS0OU0jeS3
	 suofwPvrJD8lw==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] signal: make send_signal_locked() take const
 siginfo
From: Christian Brauner <brauner@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>, 
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Adrian Huang <adrianhuang0701@gmail.com>, 
 Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
References: <20260622164029.11474-1-include@grrlz.net>
 <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
Date: Mon, 06 Jul 2026 14:39:35 +0200
Message-Id: <20260706-karpfen-beruhen-ausschalten-9f2b0a55b8de@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=353; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yy1WvoAT1cjd5MpPtTSODAFsNYQP89OHsS3LN6EvePY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5L+K+fe/uJ6FV/65uDP+bfFG06217qPiXKcr3NdkEB
 bwyvB5/6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3w+MDD3frLvm2C75P6+q
 zSf7mOn8jzJb2+x6bwtmfn0x9axw+BKGfwbOZyXuzbt8bmddxom33vZLdVW2aruEVQfV1n089qN
 0CSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> send_signal_locked() should not change the caller's siginfo. Make that
> part of the type and keep the local rewrite on its copy.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
