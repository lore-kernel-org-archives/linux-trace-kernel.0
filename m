Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C421B185
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073215; cv=none; b=lj/DvVS8TsRpLzkI41T5TPptcPj2fF6tHsTUi+CL6Md3AEYdvBHg2/2cebQ585xsEu36o888DsaSizMYL6s1//RHEWMdADjKU0LNtZ/tY3lujpZ+yqEKqJ9sq4K4AcZ8u8yyMGQHUHFF3p4jPADsBMhhpBrW5TPqloYXCjXOyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073215; c=relaxed/simple;
	bh=dV8h0t9RQFGZGo81h6/1BgtDRs/nzaIt9ePMzE04ezg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSvioZed7NFgy0Ii5zwK0E6stjxpOjXR837g9RwCgGHroBRCNHu+aq6pIT5qegtJN0NyA4sE/CXS1S26xo5Dbc8MFBo2D6MOjskmrBrv/M7ffCSLr5blYxql+z832g5KhVsshcjl66xB5WJBlO1gUhnOJyEEd6RchsT8HWLP65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hCK2i6Ms; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hCK2i6Ms"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39684525e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776073213; x=1776678013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyHgAccjQBwojxy9SLkppDf+93jdVtEuGVb2se7BTXY=;
        b=hCK2i6Ms75i6u/ndDZ80f46w6h4tn3GjtEU2/jXy3vowucNOeOO6/etUIfIwPAjcDj
         CFzoc6Xk3GEURTyJo/4bR88gppTx50E9fqEtmRz2M2oNSkEWCgMwYUG0SUReo57gYOnK
         jkJJseVXK44JYKE/+Q0GCbbALQYxQ2qEsubTN/oNI6Qjr0tMervfEfocgGth0cl663HZ
         qIFW+5EVUwvpWAn/7gqRAICPxdXu0/XExlJDKnqzlKqT275cn9I/iWhLi2rp/fCcStgn
         w/0vILMzGRIYWzHEGS0e1KloTSW5nHGdlL4u93smKNpq9kDAM0YeAxBO2FQpdWgsWz1w
         Mjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073213; x=1776678013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyHgAccjQBwojxy9SLkppDf+93jdVtEuGVb2se7BTXY=;
        b=o+rISj6v6Hu9TPUhn7qHpSdk43MTwKpyNvruA0h2sJpUYa+W2Ki2iIRgijT2zLRZnD
         NPt9Sou/5cXDsz4gsZ93kgM+2kgDQ1dotwH5lsz3Tk4zZSHziz/SeVtb+iDOA0SJzqVj
         P5JRhxH3A35sRR8IKDr20j1l+N9KcVzCs1UHs/iBvToDzGeztD/JPplJ99dZWslcikLx
         vS8XK3uXcaf9TrbzUPyzbRDD0cLcLhIwkBO7tpoo0v7HfmkmUE2GDZ/yxbI6s8oODg7O
         1jf9IwwygRWjzPEu69+hVlh1EFednmjHS0b/b/do74ILyHHc/VAAgbgjbcA8TNFKnGrZ
         Y0gg==
X-Forwarded-Encrypted: i=1; AFNElJ9LF9HKa3TkE0XXB0VOd+vAu6O87nT2xmJ6sebBlXqwpTeNqrHrAV4Fj6Pvmu77RCLqIPnr/O+XD7/tBp1LEX71sXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6i3Dk9x9AnLa64rlSEjoV22fcyBq/gB8eFIYMUazM4K6SfeM
	+ziHNVLSvIz7LQxc9MkTJGIRW4JSwMb1+y4Ewbv7b8ORX4Id1Ac9SGQanpxK6ERQHxbR3o0HYKG
	PheB9d6s=
X-Gm-Gg: AeBDietD9ZKNAfly5sp0VCMGqWqSCRGa9Dal4o2T7U2WOhQNaghhozYcIVGDRzJVb+M
	kQLZe6FAcpASf63vpluCE+4bbyotxykSIDQ6vI7+1TtA4Qn+OpggRODZt9vFW+0CvQ0VxbYCuBn
	sxULa17g9sROuBozZJcznkpYFwiy9O8Xapf51u2wuvC5odhJWlti+Zbfi9/Zo8VS9aR4vEb8sao
	174NEk5rJEcmKi2kPYVINGTMeMTUD7+MLRxoeNfRW5Amd4t7b3BpFNddfvG82zM4qoOO5HAxNFg
	vde9PADc1WO96AV8Y3AOm+RLnfqeOTIWA4iYN2BEwKDyHegYdUwp1y0DRT/UrN0cUaid5NNIjYi
	ozVgxESrv2Q7fA6WZrBmLcG5psxLrlnWKeBBo9lfrRiGaDjiA716VyhsfhNSY6vIiBu00wrAmC0
	3TW35X4Q+ExjD/zevsLTjUFT9xgyIjo/tN5hCeOWiUI7lA
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id 5b1f17b1804b1-488d68c7fc2mr151406345e9.29.1776073212703;
        Mon, 13 Apr 2026 02:40:12 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm296253965e9.13.2026.04.13.02.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 02:40:12 -0700 (PDT)
Message-ID: <41e81533-0fd6-49f5-b7c1-b4e172affd2a@suse.com>
Date: Mon, 13 Apr 2026 11:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: preserve module tracepoint strings
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260406170944.51047-1-create0818@163.com>
 <20260410051847.73259-1-create0818@163.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260410051847.73259-1-create0818@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 7:18 AM, Cao Ruichuang wrote:
> tracepoint_string() is documented as exporting constant strings
> through printk_formats, including when it is used from modules.
> That currently does not work.
> 
> A small test module that calls
> tracepoint_string("tracepoint_string_test_module_string") loads
> successfully and gets a pointer back, but the string never appears
> in /sys/kernel/tracing/printk_formats. The loader only collects
> __trace_printk_fmt from modules and ignores __tracepoint_str.
> 
> Collect module __tracepoint_str entries too, copy them to stable
> tracing-managed storage like module trace_printk formats, and let
> trace_is_tracepoint_string() recognize those copied strings. This
> makes module tracepoint strings visible through printk_formats and
> keeps them accepted by the trace string safety checks.
> 
> Update the tracepoint_string() documentation to describe this
> module behavior explicitly, so the comment matches the preserved
> module-string mappings exported by tracing.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217196
> Signed-off-by: Cao Ruichuang <create0818@163.com>
> ---
> v2:
> - update tracepoint_string() documentation to describe the preserved
>   module-string mapping explicitly
> - address Petr Pavlu's review about the comment not matching the
>   implemented module behavior

I questioned in my previous comment whether the data associated with
tracepoint_string() could be dropped when the module that created it is
unloaded. Typically, modules should not leave any data behind when they
are removed. Note how kernel/trace/trace_events.c tracks event fields
using add_str_to_module() and releases them in
trace_module_remove_events(). In practice, I suppose this isn't a large
problem because the usage of tracepoint_string() is limited and one
won't typically load/unload different modules that use this facility.
Nonetheless, what is the reason for keeping the tracepoint_string()
data for unloaded modules?

-- 
Thanks,
Petr
