Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1A13AC0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906267; cv=none; b=psUupubdlmDWQIamDw+BGRzpbcXy88aZ6Xx00InThJQASyRmi9vW5wUOTCmKuwEYPLQQa/qnWEQenX06//yZMnY1ct6OwOdpqBYpR476UiCYv2SuPOlX475LFrds8gDCIEBVKKssUKnMzOF/z31NDhllfE76vu+HJl1woXsqMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906267; c=relaxed/simple;
	bh=333B+8NYzcR8ybiLlWgtlZDcGDpqQjlE1EWL2/4e6Y8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uQ0AJC95ozKMCuPCWKSyNGSPfmb084h8DHGTB+brD/7tqM92LPXvpYBXcsOfCkGBnX6LA3x3XulY4yK0XhXOnw2P18H+234XkrKfya28yJtlWHudr3VYPz+8vl5sZMcNpvZsrIQIz1RI3J6DM8Nd8QLDivMtBFKU2V1Whacp7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd6sGDLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd6sGDLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98743C433C7;
	Wed, 20 Mar 2024 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710906267;
	bh=333B+8NYzcR8ybiLlWgtlZDcGDpqQjlE1EWL2/4e6Y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yd6sGDLcreFeoREUD3oWJARew7ibyz8gYRd+Yiv0kRgQaNfV5AiZ9+NcyIgLaAF+j
	 jeFtvIpVBv7BR3Jq7LavDoFBAg6r/nVUM6e5Fsr6ossU+zFScsULr2RTjwEJc6Z1tf
	 4oxmlNH9Ybt28woDm2ncQHB9RX02G1V3qzCbEjGHeQyiU5LU6q7z+PqWLtzZ9UxrQn
	 NhA/tjR49vKDMz+egDN7HoChzBpTKKNOvhhDwVVPU0QA1T1bmrlxX1aYdEoKV1Kg1C
	 VBUVjTp0PhluWebG0c2SmDjwc34qonKWQIL2esWPNwSZxDCjQVDiv0p7fDBl7lvtNf
	 pPWUvKJBH2Igg==
Date: Wed, 20 Mar 2024 12:44:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/probes: Support $argN in return probe
 (kprobe and fprobe)
Message-Id: <20240320124423.54cdb56dc8a07378fd09de38@kernel.org>
In-Reply-To: <20240319101000.4dbe0cc5@gandalf.local.home>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
	<20240319101000.4dbe0cc5@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 10:10:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 Mar 2024 10:19:09 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Masami Hiramatsu (Google),
> > 
> > Commit 25f00e40ce79 ("tracing/probes: Support $argN in return probe
> > (kprobe and fprobe)") from Mar 4, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	kernel/trace/trace_probe.c:856 store_trace_entry_data()
> > 	error: uninitialized symbol 'val'.
> > 
> > kernel/trace/trace_probe.c
> >     846                 return;
> >     847 
> >     848         for (i = 0; i < earg->size; i++) {
> >     849                 struct fetch_insn *code = &earg->code[i];
> >     850 
> >     851                 switch (code->op) {
> >     852                 case FETCH_OP_ARG:
> >     853                         val = regs_get_kernel_argument(regs, code->param);
> >     854                         break;
> >     855                 case FETCH_OP_ST_EDATA:
> > --> 856                         *(unsigned long *)((unsigned long)edata + code->offset) = val;  
> > 
> > Probably the earg->code[i] always has FETCH_OP_ARG before
> > FETCH_OP_ST_EDATA but Smatch isn't smart enough to figure that out...
> 
> Looks that way:
> 
> 		case FETCH_OP_END:
> 			earg->code[i].op = FETCH_OP_ARG;
> 			earg->code[i].param = argnum;
> 			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
> 			earg->code[i + 1].offset = offset;
> 			return offset;
> 
> But probably should still initialize val to zero or have a WARN_ON() if
> that doesn't happen.

OK, let's val = 0 in the store_trace_entry_data(), but WARN_ON() in this loop
is a bit strange. I think we should have a verifiler.

Thank you,

> 
> -- Steve
> 
> 
> > 
> >     857                         break;
> >     858                 case FETCH_OP_END:
> >     859                         goto end;
> >     860                 default:
> >     861                         break;
> >     862                 }
> >     863         }
> >     864 end:
> >     865         return;
> >     866 }
> > 
> > regards,
> > dan carpenter
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
