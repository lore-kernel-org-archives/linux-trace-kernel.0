Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAA63B9;
	Fri, 11 Apr 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380281; cv=none; b=pTuWcJzFHEP7Nt4aGEs3nFXd091ZqeMdod/IldOBroTKXmM9JEVQ+IpINWqLdWdA5uRj/7DGmUmqs9Big6zlr8QLRqUyB+XKWZli5WLFNwWvBOFotcZQikGu3kWPpi2RJEb/2tFHbTau0fBLNmNq1KZWVhgdH4oqItoBjve8ykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380281; c=relaxed/simple;
	bh=JqIaSwcQTLnteqKdk/e79JKvBIxPhUAuMFVFJtOtX/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwN2NBVDh6lEk5eawMlTuHegWo5L3CNoFNvlPJ3/8sS7JgN6zjhx3jw9GtOAX3zHc/g0OEHct/xidyN0nOfkna0PB2uEB3kqRi+eEQRkvx0g1x7CBtejh/AN2irsV3lvQGGEeE3wRAXIoK2SiAp8Y+2Byf0KCiJB3XMuGCwKnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0EeUS+Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+yLPPCCR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0EeUS+Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+yLPPCCR"
Date: Fri, 11 Apr 2025 16:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744380277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VfvJqPXeFnMlJmDgFmRfagJyG6Zqa/JynZ0wj1VizA=;
	b=J0EeUS+Y9srDohJFWcRB0YV8XOw0F+QJ/Hb2F/Du1yCUX7NTsiC/YdSoblsXpDNZeyImLx
	Fw+rhRZWzIc+GYFFdiFTTj/zXAiPBX/BJeS5FBX/LmXU2NIjmqle+WGjszwsTsTovGdDAk
	fsrmptLgRlCDnbL89JHkyQBMdlK0b4yO9AivWYXESdqawk2Trfwvtu4Ycm7BtlPFmCllPB
	5ZF9HNo+0hgQmYRv2/pGmpiUxnn5LwJ1KJe4vWlG3M5t/pCChGHTVQHBD9mq52izraRiq6
	THkA7v0HTzR5ef98gRP8WikvnkQaafmcvf+iazx+OXutpt3zpwe0IwUzX0e6RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744380277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VfvJqPXeFnMlJmDgFmRfagJyG6Zqa/JynZ0wj1VizA=;
	b=+yLPPCCRjuWDeF5bNIaPNHu1JZPF52h1Oa/RffQ872BRnMQv505ub7Ai/L9HkFN85Zt4+k
	sj97KTPvzi2lKtCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: john.ogness@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/22] verification/dot2k: Make it possible to invoke
 dot2k without installation
Message-ID: <20250411140433.QiY-1pL2@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <caa6a7668f958c68fc7b8a40256e3edf3f11ae99.1744355018.git.namcao@linutronix.de>
 <4b4c9ac8411e6398b7d4487541d978f908785d27.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b4c9ac8411e6398b7d4487541d978f908785d27.camel@redhat.com>

On Fri, Apr 11, 2025 at 11:23:25AM +0200, Gabriele Monaco wrote:
> On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> > Without installation, dot2k doesn't work:
> >
> > namcao@yellow:~/linux/tools/verification$ python3 ./dot2/dot2k
> > Traceback (most recent call last):
> >   File "/home/namcao/linux/tools/verification/./dot2/dot2k", line 12,
> > in <module>
> >     from dot2.dot2k import dot2k
> > ModuleNotFoundError: No module named 'dot2'
> > 
> > Installing dot2k to the system is not always desirable. Sometimes it
> > is not
> > even possible (e.g. no root permission).
> > 
> > Restructure the files to make it work without installing.
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> Mmh, the workflow
> 
> pushd tools/verification
> ...
> popd
>
> 
> has always been working in my case, but probably that's because I have
> PYTHONPATH="." , not sure how much of a good practice that is.

Ahh, PYTHONPATH is the trick. But that shouldn't be required. The scripts
should work out of the box without any environment setup.

> Anyway, since you're already moving things around in 9/22
> ("verification/dot2k: Prepare the frontend for LTL inclusion"), does it
> make sense to keep the commits separated? Or you could directly move to
> rvgen here and just add the ltl related changes in the later commit.

Yes, it makes sense to move them to rvgen here.

> Also, after your changes on my system, I can run the script from the
> kernel directory too, which is much better than having to cd to
> tools/verification .
> If that's something portable, I'd change the default definition of
> monitor_templates_dir and allow the user to run the script only from
> the kernel root.
> 
> What do you think?

I actually prefer running the script from tools/verification. We can allow
user to run from anywhere, with something like:

 class dot2k(Monitor, Dot2c):
-    monitor_templates_dir = "rvgen/templates/dot2k"
+    monitor_templates_dir = os.path.join(os.path.dirname(__file__), "../../rvgen/templates/dot2k")

Best regards,
Nam
