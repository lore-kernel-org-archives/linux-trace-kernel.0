Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110820;
	b=Zpo5hAwBtTfJO2HscH4Yw8r1/FMYlRpoRWEh7ceehsb+Pcmcm9UJ3bwDDGzRvqbnhzSx
	 NqRm68BYzV/ZiRQQu3PufpmBB7JZORZj/gsrQRJwG61Y0Ot73khFONs5hOMNumjSncjdn
	 lFOFYkn/CR5cMwKlKbefmGeG2a0Rd7kSb5LFgnya5WNJ70O/PTzMYHdoKR3NgyfOd7lpS
	 KJmDE1js05mcvGsfto0/N7qsQzsCTy+nw7ePR7kwP6sAmZKMiVoqHF1VtKiEstjsF8hlm
	 mKsNis8IyRjot+zj1fQYimcPBMBrjbPMOvMUoqoGuBCByIWQOaH3B5N5WpdvLL9Jk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110820;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hJCg+XbMnRMBhiKjEjeT8w7wARaC1BPxG/DUhq3lCU8=;
	b=ZxNKiIamAqgTNOhSF4TNeo1K0r4khKKfuWXD/6swoK+AXXXe8OFGhwNZ8spbDIAibUjg
	 0h+zQxVCm1i11KOqs7+JSrhwADWEySKA+NM7csw1TCEh3B1biY28P5xNXyF8p6SnTj+e/
	 O+mwCCr0igvVLu5P/EzcNHqM+yvAeCgzDDrxy5uM+cX5NGG26Ir3bNw0UwGg05lPBRvWl
	 i5HWVjWT9af+d3iVUuBLjbTu3ctAMVnNaqkFoiGA18RlVT6MlGTSUI+2RZQ8+f3p+2p6g
	 4Iuhh/swvLw4RuTF73CdHL7SjmeLco6AdiZ2Td5GZLp3/iUdC6l29p8BXqjxIGMz1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mVLM5KKR;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5823606A324;
	Thu, 19 Nov 2026 17:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5823606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mVLM5KKR
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CC5161A0BF2;
	Thu, 19 Nov 2026 17:53:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 9630F18;
	Thu, 19 Nov 2026 17:53:10 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:53:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fgraph: Fix the unwind hint at the end of
 return_to_handler()
Message-ID: <20261119125309.75c417b7@gandalf.local.home>
In-Reply-To: <20261118235023.14978-1-evanfengff@gmail.com>
References: <20261118235023.14978-1-evanfengff@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9630F18
X-Stat-Signature: afzuo6dbw63qgfkmo6q6gu8soyrwb81a
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Gq7XJ8V1UpYeXQrjMQNB4brqcnuwjE1w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hJCg+XbMnRMBhiKjEjeT8w7wARaC1BPxG/DUhq3lCU8=; b=mVLM5KKRBVOw2NJ+UWtMllLW/VsNh7zqW4fPnbtvAcs++Tl7V3+zpjb1PwXoTe8ufMr8ghWhJnsuXr5x2kxW9I0HoBgW73hayW9a0bUluL3HEGy7BUKt1zi0pJT0ou0BYiClStlsd/tpYcO3skGUjsarD+58bDqF3fGjDOyBYKo=
X-HE-Tag: 1795110790-414938
X-HE-Meta: U2FsdGVkX1968l1X1EPEQiUL9PjIoQT/vd38afUI/UykW+nQ1GV+SjeYCr+D5CfRTCr7Ophv8NiKepBzl1I6dtQViQ/e5InzdOnXY0pM2qFx1lCRDqjgIDH9a8ibqD1LS6qjUbxIL8MntJE0zh4V8ika1e6DgONdV+oH40mvaDtDLGed1+KtBB+St/sqgrPLgetM5v9u/7AgsORqhRVezsDAh1yYH3x9aXxGeNpHK2eEEFJ2N62bPiASKRejfG/CWiiu/8HUM0wntLhT4kOxhG4T7/h7Phow4mG2cgXqhJvRizAroVBtxTAnwEWV6k4DqJzQO2NfN7lGO23jcmskhpIwrQJfvCr4q3HKNsSnjwvWBpqfIaDwjXFnYtyMHvYElsbthRcI4kbQIqlrl77kVVDBtib6zX3tpVBGIbTKCAun8KfxrAtATg==

On Wed, 18 Nov 2026 15:50:23 -0800
Yifan Feng <evanfengff@gmail.com> wrote:

> return_to_handler() reserves 8 bytes of stack for the return address
> and marks that with UNWIND_HINT_FUNC. The hint stays in effect after
> "addq $(FRAME_SIZE) + 8, %rsp" has dropped the slot again, so the ORC
> entry of the following call has CFA = sp+0:
> 
>   return_to_handler+0x41: sp+0	call .Ldo_rop
>   return_to_handler+0x46: (und)	int3
>   return_to_handler+0x47: sp+8	mov %rdi, (%rsp)
> 
> A stack trace taken from an interrupt which hits the call or the mov
> ends up at that entry, the stack pointer does not advance and the
> unwinder prints:
> 
>   WARNING: stack going in the wrong direction? at return_to_handler+0x46/0x50
> 
> The return address is only in %rdi at that point. Mark the code as
> UNWIND_HINT_UNDEFINED again, as it was before the hint was added, so
> that the unwinder stops there without the warning.

Makes sense.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Peter, can you take this?

-- Steve
