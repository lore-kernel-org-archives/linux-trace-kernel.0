Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8851E1045;
	Mon, 21 Oct 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545144; cv=none; b=lb5RpksEFNIcHJn2lk3/Fe0T1/j3mZ2hwzuhnbIar2gpOMMT7kfcGHrEpOnX63daJSStkUIf+kaAQ/WAvZsdyHgsAhhGRFwP4U3zP6lhk2n57ePdIDUZNaJiOBnXHj3aITIJ57tZbV49eTzZucbGf6MBefTJo0ZGIrU5eVJMwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545144; c=relaxed/simple;
	bh=KuPztDv7ggupu/upOVkA2KT/eVBKur7UN2wM9Xt5FR8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AWVnfPmYR0i1EwxkRQ19bIzYFYNlKoA47pTg5IGFtQuiqow7wvq0NMJkWEvqEmGHYe4gGSuDF2dx3JDrL2BBXfqN7ViQlc9/HzGpr2HvdtGiAm08Vk+XmlvO+vg4xnfMbeUjPq6Llza9xliaBMgdfUlJjULECL8fbcWrCdXkaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=p7j9LCjx; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="p7j9LCjx"
Received: by lichtman.org (Postfix, from userid 1000)
	id 0518D177106; Mon, 21 Oct 2024 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729545142; bh=KuPztDv7ggupu/upOVkA2KT/eVBKur7UN2wM9Xt5FR8=;
	h=Date:From:To:Cc:Subject:From;
	b=p7j9LCjx19f77YziYjAACed145az7xKhhiwrXnMgilK8uXPRcZ6xIEbYiIDFZhlOk
	 k/FCgID6OwNtRdk25hKMFOgldU/UG84ouxXovrSrnLkyw0cmgnNMV5/u0qjOwAaUmb
	 LYkMPDbq765uDy8UOmEllL9RAalKB5+qGOjN2z2AqwlYQkpj3Z6K2bqVsH4CcSXbij
	 axHwYUb3UGOLr+WSZh0gP1OO/vMVIop2DWPC3Iy2l7Jl3zciiso3i182g0xbZlCprX
	 hPd8QjHuRyHfT9ghb+axWbA31oeKuqcdghKIJaouWGXTM/ceJcwcHTWvbQxFCJkTe2
	 OeCZWsgcN4QGA==
Date: Mon, 21 Oct 2024 21:12:21 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/2] Replace the use of simple_strtol/ul functions with
 kstrto
Message-ID: <20241021211221.GA835676@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The simple_str* family of functions perform no error checking in
scenarios where the input value overflows the intended output variable.
This results in these function successfully returning even when the
output does not match the input string.

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch series replaces uses of the simple_strto* series of function
with the safer  kstrto* alternatives.

  
[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Yuran Pereira (2):
  kdb: Replace the use of simple_strto with safer kstrto in kdb_main
  trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump

v2: Nir Lichtman (2): Removed confusing support for hex number inputs with no preceding "0x", and other CR fixes

 kernel/debug/kdb/kdb_main.c | 69 +++++++++--------------------------
 kernel/trace/trace_kdb.c    | 15 +++-----                             2 files changed, 23 insertions(+), 61 deletions(-)
