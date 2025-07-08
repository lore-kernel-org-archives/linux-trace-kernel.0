Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F9298983;
	Tue,  8 Jul 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961018; cv=none; b=ISsMtvEeZ1r2LXcwrs/mPQOIPyEkiFPuAOenLp0pR2L8H7J05W9ly9EYZOUIUdNRXEpLgS3XP2Rt08zht4xGHXzmuL+zXtXpa4VI4Q8b0C+Gr0DVrXHDI2pyHWliDycoHiUUQTPCEqq1DC+xnnpiiwHlmR3SIfA8UJnRKr2zNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961018; c=relaxed/simple;
	bh=bp8wxgQ06nWmM2ZEK7BMnYwzPK2cJ1ftNM3z1kB5UbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dySIbasKz3OgQqsdVhvO4788TyEYemQyv0ZTqlRxspE+CHf0X62D1QO5cB379iOXqiT6gO9Yp68XaGO4c41OFzKwdru5mNmqqvctwEpRJlG1VdsbcoRPY5I4YoumoKjSMqpXtFaXtY3FM2+eF5UB2p+DZfoi5kBY99bwFAEnpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q02YgEe7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+z4SYro; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q02YgEe7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+z4SYro"
Date: Tue, 8 Jul 2025 09:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751961014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AaSSFAIVJg+nrHF54Fxykfa7qVOo8icj8RNY5lB8ERc=;
	b=q02YgEe7f2DE0eQedcOfU+2mv66JXzVOubhGsCxTuCFMdOM8sEX5UWDaCPKiKfXZwN0M84
	gRYkTFHxdzThmTIfRbPG9N01ZiyUGzZkfJy6F8RbXPegdUnpVcwCe8x8YlUnWdFwmh5NJ2
	gQci5voGId6r6up46fCjgMWoMGOVNILwaPN6xhNPO/oCkIKvwM/8CIo3TFPHVeD6ufcWDI
	9UQ8cNlsUGvnpG3Ty5WGeGTeE3pXqw+niuyb++Id6D3jXEbZ3gf9m7Ygdx8MJ4lP6qJSO8
	zmpJDoWj66mvhqD2pILs1A4n7CwoWFIpzbg0H6MXlgCPIbV1dapF1p0N6XIntg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751961014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AaSSFAIVJg+nrHF54Fxykfa7qVOo8icj8RNY5lB8ERc=;
	b=H+z4SYroc5SaVsN9JI+QCEYflST+5opIKgSuEVnCb3vS3xZfCDO76t1fjhI7ofZ58L+V48
	q5EjNnHdxQSPxOBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250708075013.hMCRH87n@linutronix.de>
References: <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
 <20250630203401.1a11e58f@gandalf.local.home>
 <20250701051757.mBjQVdoo@linutronix.de>
 <20250701110218.5e742850@batman.local.home>
 <20250701110551.5c2dc2ee@batman.local.home>
 <20250701151114.OJQTlRCY@linutronix.de>
 <20250701111704.00456667@batman.local.home>
 <20250701210338.BooVbo54@linutronix.de>
 <20250701171715.5a1a99a0@batman.local.home>
 <309ecabeacc72f13de7b190f37423f1aeafe991d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309ecabeacc72f13de7b190f37423f1aeafe991d.camel@redhat.com>

On Wed, Jul 02, 2025 at 08:29:28AM +0200, Gabriele Monaco wrote:
> That's a good point, at the moment the DA monitors have a comment in
> the /completely/ generated files (the automata header), the others
> where just a skeleton is prepared have some hints that we removed while
> filling the monitor.
> 
> I'd say for now it's good to just add a comment in the LTL header (like
> Dot2k:fill_model_h_header), then we can adapt all generated files
> (whether fully or not) to have also the actual command that generated
> them starting from the model file.
> Or did you have something different in mind, Nam?

Yes, I think the same.

An easy way to do it is just dump out sys.argv. But one thing I'm unsure
about: I prefer to execute the command from tools/verification, and the
command I use would not work for people running from root directory. I
would like the printed command to always appear as if it is executed from
root directory. However, I see no elegant way to do it - will need to think
some more.

Best regards,
Nam
