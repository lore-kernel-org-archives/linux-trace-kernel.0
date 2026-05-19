Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B45409621;
	Tue, 19 May 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196740; cv=none; b=D9DESkXgGOgtpOnlBv8zoTsrYe9zeiHhirmMqQyw9dJFPyYIGZKwiJlKdx2UdX7fV+hxG5youxUgeFZvUCQTmFwsvj1o+Dih6DHSZ0kXVS2mYzNNFiscitVWnfuYy4r9Ae08gWn0A8M+wx4SPzf1FJDQdeB5QEdtgL/f5dm4lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196740; c=relaxed/simple;
	bh=IobUvsl2BhsipYNAile+hhK8S3xWvtYKNJAhnxecp9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6D56gkZGFgB9dOWlFQFB9KxGFtgazVmktPcQXItO7hVV6xygZHL4r6Wze5PV6O+8tJGu8SmiyK90Jn5drcdWPDMIUfm7VN5JjzsWCtOqH0XJNofkKNKuMIiOngeGvW9hlz94JkDAft/aCW6uIcK9FeqnXBgoOAyom/KMbcRXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBthiqAe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtpVnwXh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBthiqAe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtpVnwXh"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779196738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rkigfq6uAw/CJ0nuq7DOj0gDNGYVxrkmq7sjHqiT6uo=;
	b=xBthiqAe+OPk9KivCv+W6qAGd3dTEXhXZO2YI1QAmt9aAGeR2F5aJzDBSvTOw54eLai4Tr
	TTPRSuRA8NseXCgUC8NAvJf/IZa+Gi1nM29CWsp145j7OUJ7rGV7aUfFRm+P49SwxVZNLH
	piJaLzAIfmOZ97GJizy2Btmbz4izvJCu6cSMmbg4xdemMsLILp4fU3o1XqCE4qdhHOknrU
	M/w7NYlugQswK+Nmc9i0OUHiw4HxNn1EecITK45Jk8bA6Lq2/aaYidZbyAJxrfB80gn5tc
	I3pMBJwzMCdSFeV1QWqrIos47s4jeaDlFtjcJghdYYJW5HMXSsnvFHDItMgwwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779196738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rkigfq6uAw/CJ0nuq7DOj0gDNGYVxrkmq7sjHqiT6uo=;
	b=dtpVnwXhR0XQrJs/cXVqQSZPBoUIGa0z/015JDeraJTayebzAJex16Y1c32XqqlAYO1XCg
	groxqHTCn2wBSZBA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 11/14] rv: Add KUnit tests for some DA/HA monitors
In-Reply-To: <20260514152055.229162-12-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-12-gmonaco@redhat.com>
Date: Tue, 19 May 2026 15:18:57 +0200
Message-ID: <87cxyr4jwe.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +#define RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)                             \
> +	for (int __done = ({ RV_KUNIT_EXPECT_NO_REACTION(test, ctx); 0; });  \
> +	     !__done;                                                        \
> +	     __done = ({ RV_KUNIT_EXPECT_REACTION(test, ctx); 1; }))

Cool trick.

> +static void rv_test_stub(struct kunit *test)
> +{
> +	kunit_skip(test, "Monitor not enabled\n");
> +}
> +
> +#define DECLARE_RV_TEST(name) \
> +	void name(struct kunit *test) __weak __alias(rv_test_stub)
> +
> +DECLARE_RV_TEST(rv_test_sco);
> +DECLARE_RV_TEST(rv_test_sssw);
> +DECLARE_RV_TEST(rv_test_sts);
> +DECLARE_RV_TEST(rv_test_opid);
> +DECLARE_RV_TEST(rv_test_nomiss);

Good to know this one. I think I can make use of this trick for some LTL improvement..

Reviewed-by: Nam Cao <namcao@linutronix.de>
