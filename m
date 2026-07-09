Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA73D890C;
	Thu,  9 Jul 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584134; cv=none; b=ndCviXDcRYJyiHAXexwEgxUV/CnVzrSz3pj+R/Mfge6XdsWBNoV71P+G6Iq54A6an2OlEzHA73SiuwIE0JbjGmPrROtzrnBvlu9W7VzqiS7Rr54Mqa6YvDPq+DrNhH006Rvz11eoFzMEPcFSj1emOtDbuypzvCKYD3KF55LEWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584134; c=relaxed/simple;
	bh=1EmVten3z1ngcG+Z0nW0Vlp7SLtQKVSPU1SE8f/bp40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARPKYhAIdUwf6yMT+CdWIVzpG34/ItLOJ3ztwg1hcwXvFzCwuSkANZ8vo5GADhZ34VXCvAZXZFaTQ6e5PIk0SK/e5FDAR5rrHLsufut3DyNO7Qqr5osBdTItT0G0IrTNWfsZil6Wc5DEyLJ35JUOP49CDtz4s2oY/sujr79dmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpkuRxvK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/rY1Rh7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpkuRxvK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/rY1Rh7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783584130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6ZMvUmoi/TLQL5zvdZ3jAX1Nlm+DKcmk9s4D1hMFGs=;
	b=xpkuRxvKaN/cnp2joWCd7nanZdPwijW/wka76ExIyKebagbkLGyHBjPxLbY1g3eBs4zNKX
	fqtcm2Mo7rTEU5PZ30O9KMVmABuHjQxMhaiQg1k2XptQt987glUaTF45AT9m06hxuw/SSy
	0BItvPS2H/HogqWotP5CtGg/FTvj5hV5/Sfjmm6z1pDDrnTJ8Yerq7HraAHHWedsY6x6it
	5n5kgaLJRM0MC3DyCDcsgu7jplx902rUOArvkcPOtVnDxmHOV06iGki5aanTk6nW1Lrbr/
	ZiVTcBGPtFLGunrA4ndu/0lLfYkTpr+ybfdJa5f1mKHlgP1BqAWaiBTF4pZ1Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783584130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6ZMvUmoi/TLQL5zvdZ3jAX1Nlm+DKcmk9s4D1hMFGs=;
	b=+/rY1Rh7nUXA+tHfPyH2rSrKzutC7bAC9QZ8jInANsoBpIAmaT6yGSe7K2IwjxiQU1xs/g
	LeNIsByPjNUzcGCw==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 13/17] verification/rvgen: Add the rvgen kunit
 subcommand
In-Reply-To: <20260625121440.116317-14-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-14-gmonaco@redhat.com>
Date: Thu, 09 Jul 2026 10:02:08 +0200
Message-ID: <87cxwwfv5r.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +    def print_files(self):
> +
> +        handlers = self.__parse_attach_handlers()
> +
> +        if not handlers:
> +            print(f"No handlers found registered with rv_attach_trace_probe in {self.monitor_path}")
> +            return

There is no valid monitor without any handler, right? If so, should we
throw an exception here?

> +
> +        print("Found tracepoint handler(s):")
> +        for handler in handlers:
> +            print(f"  - {handler}")
> +
> +        prototypes = []
> +        assignments = []
> +        for handler in handlers:
> +            arguments = self.__extract_function_args(handler)
> +
> +            prototypes.append(f"void (*{handler})({arguments});")
> +            assignments.append(f".{handler} = {handler},")
> +
> +        struct_name = f"rv_{self.name}_ops"
> +
> +        self.__fill_monitor_handlers(struct_name, assignments)
> +
> +        dir_path = os.path.dirname(self.monitor_path)
> +
> +        header_file_path = os.path.join(dir_path, f"{self.name}_kunit.h")
> +        kunit_c_file_path = os.path.join(dir_path, f"{self.name}_kunit.c")
> +
> +        use_backup = True
> +        if os.path.exists(header_file_path) or os.path.exists(kunit_c_file_path):
> +            try:
> +                response = input("KUnit file(s) already exist. Overwrite? [y/N]  (N for backup): ")
> +                if response.strip().lower() in ("y", "yes"):
> +                    use_backup = False
> +            except EOFError:
> +                print("Non-interactive session detected, not overwriting existing files.")
> +        else:
> +            use_backup = False
> +
> +        if use_backup:
> +            header_file_path += ".bak"
> +            kunit_c_file_path += ".bak"

This is the opposite of what other software do. Usually they copy the
original file to a different name (with a prefix or a suffix), and
overwrite the original file.

I think it's best to follow the usual practice to avoid confusion, maybe
something like this:

if os.path.exists(header_file_path) or os.path.exists(kunit_c_file_path):
    try:
        response = input("KUnit file(s) already exist. Backup? [Y/n]")
        if not response.strip().lower() in ("n", "no"):
            ...rename the file...
    except EOFError:
        print("Non-interactive session detected, not overwriting existing files.")

Nam
