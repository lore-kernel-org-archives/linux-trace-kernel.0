Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE21344D8D;
	Thu, 28 May 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957533; cv=none; b=WaabErk0z7UMnmJWw+JpLsjijfpY2uQX9x8btSJDBs+MAU7xiD6jmPOVK/T8g4Z90Q+sO5W5N1V/Qzp+aEOLzm4vY4eE2QZIyu81mx9CgVeThDFlIXfO1ThcYW9R1K3AGFnfFcxO4bXZ6n1fZLNTMDSy2TugU5QIJtMnhYer/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957533; c=relaxed/simple;
	bh=z0usdWbn+9/vJHEyfbsOH9hI1I0Gsf+4Dqw0YzzNT7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTmuDEeIXefoeKWzjf6dIyHMAh0PWn2NdAaUUySGwRp9hF6uzdFa72JDCYG4vHVfc+tflHF86yrMl/Qceq+oLdxoqwxoX4drZP6stgAwNa0IwkTpk/rl7eS/qVSsqJCYw7hyK4pPVcddRLwHNlkF6zPVZ+Z4shMCFyLWWxx6GQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POGUnfvx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6C7RgSpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POGUnfvx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6C7RgSpJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779957530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0usdWbn+9/vJHEyfbsOH9hI1I0Gsf+4Dqw0YzzNT7o=;
	b=POGUnfvxkqO1NHSQERNbHQen679OBw5QlJqno6UUP1rxpSbvGcXBBZOKz/QOOnFBmC/ymJ
	ZO0j2Bmp31xUMZ9PoHrkeAbljfLB1ZCg8L3mEp8wALr10U4kT7SPgqvLRGm4AgYDTxfg6k
	QRh/DT9hWFuVtBv2cCB131QcTeb73reCau7RKNHolTWZpHcnYZhCaSPyBQGJ9CxphD8tPX
	v8yNNaZ6j7xxrkBrFN+z6ltQnUfgIpJM6v0qXts0Z+epiAsRpdcafoAnaEG3pzHJeDIdDf
	uHhA0Gr8qznjXTuD2/U42oveN7uqPNlkTOBVOrjOWVpT0JRDTC4odm51cLgPhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779957530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0usdWbn+9/vJHEyfbsOH9hI1I0Gsf+4Dqw0YzzNT7o=;
	b=6C7RgSpJ7zNN4AGfzCYNMbKvk41mrz6WYVIsN6K3rzpmzaOxhNjfPhgeIZKZu/C/fIDTAF
	xMLT4lZEjpfxLPCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 01/12] rv: Fix __user specifier usage in
 extract_params()
In-Reply-To: <20260527062313.39908-2-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-2-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:38:49 +0200
Message-ID: <87o6i0nd2e.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The attributes variables extracted from syscalls in the helper are both
> defined with the __user specifier although only the actual pointer to
> user data should be marked.
>
> Remove the __user specifier from attr.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604150820.Ny143u6X-lkp@intel.com
> Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
