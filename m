Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039467;
	b=F8QDqnNWSj/Hk86+JamDa44WpyXdeBZ6T7QYmFpMcCKMp2/muiaKCVhElGSQCSNCYPJY
	 cmxEi02jFwNR4onylfA9Z3qJjUtqW5xiX85IvXZQhJ40qm/w538d+eK2EVoNpFi1iRrkT
	 FvOWmB3MAjX/06XKaVDb0q+EVEiX0j8E+xV29c0UsIv3er7p4F0MW5mWD1Sc0bMNn2Y+y
	 RLF8Pa558VU+6azP5Mj6wkCQas++RsbRVLivzLPwcdDqEvQ0G36w7xaLR7G12Y4pLPgEX
	 WHf/Xm3A6H+lZI/PsYGyu0mWtyqMCUBvOivAJI9o7L+fOj4rFZncKneO5Uu1H4CFylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039467;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=Ywd/bRlbViRVpRblQwhx8RbS18N3XAn9LKfhGzEQGQQ=;
	b=aKzncWqS+sau8h9I/Yp2/Heg/4wQUw26P0IV2Pxx+77Rkt2QhZTC1ay+QtMdxpm6zatb
	 Zg+WZ3dQeGJ931DvtNmn6LDb9+B3eUtqU5iHVMZwqIfNh1YZ3PzUmtNO0oKvpnko4dgeg
	 y7WgXFyrWUdRMNNhohUZpXi0tKnMlgKn3KrUtMz80AdjU7XkRenW178fpcfilE1vyzog+
	 qzALaEIIu5NquLSC0XQZ6BmdiNLYrbOyBJQ+STuBHEK0cYkg01ttXmMmG1B7AHJzyMR+P
	 WDjRGe/i0zob8/fS54vr5YDMXt2uQWhQ/b8BKLE4/HoDYKunNwKbxoza8pJbgpcgx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ZFE3z0Uw;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207E606A325
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 22:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2207E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ZFE3z0Uw
DKIM2-Signature:  i=1; m=1; t=1795039464;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:IOuRCTB8jnHO4U6YgPZta+VIDB73
   xr3OjNGksA37tTBuxhJblI2Pl+PT+VXB3BK3JzxP3vyhvk7KazoqR1He8DIIUx9ZBKpDN580jQI
   azv54WWuBuxyklZRqlz/A65Jpgm4JEIHS6SZOQlWf1CXFjG9qxcrG1lAlOPArrFwpqPTgarKfP2
   knlitooWdgP9URH+BTEOKRcIIwJA1GNq7qY5ASZGmhIDxt4zHfD36a5JQ1aSOVrzsbbxQHNENIv
   4bCo03dFk4VFRCZRtnbOBGyPz7lqlqBmV82U6YSu5Vw29jhDpuKugVUTE1Mm+0Tae4YHmLSGJ9s
   YZngardtD+pUbA==;
Message-Instance:  m=1;
 h=sha256:
   mcwfK2KfdWAz/r6tcvOwHL/cSosKV4IMtbzajrrge2g=:
   kmQTQkGGZ8SJqY4N+RxKYTmquPfIAVm4DAZAgVTJv+I=,
  sha512:
   kL6H6ParmSBplVe3v85uT4Ui0FCgYgeE+E4uqGmKMFc247JnuoikFE/D6lcOIaKuxfFQhfHCS/nOdIu/MpZuDg==:
   CJ6j4s6gol3py/X8OCQOaNpRWAzHT6TyfmIZ7ZBbcYl2ukCqECpNHLwEqFFaWubfqxjlqxrn9xJOP5O72vfl7Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795039445; x=1795644245; i=deller@gmx.de;
	bh=Ywd/bRlbViRVpRblQwhx8RbS18N3XAn9LKfhGzEQGQQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZFE3z0UweCdgYgf/5ChjXIwYjbK9Sl7ZRO/c/+z2Q1ST4RJrbK740HLW97mi8YkB
	 NLeRf2VyHiQeyqh1nm0w8ikl1c1IMf3Prgslpt3vVx1gxKexfmzZdAbBYGrL54tFy
	 EkVHTfo2vJwCUlvkgXyOyVBG/NfT+bNwhnxiMkPDaFtOy20uwL1o7k1lOHK3ji8Rg
	 Tonr+hZvLtH34XFxDBZQxcBRjRHC+g0RjyGh1yj3TItae/FnoSnziiDxhTrxfKEwT
	 FAZabljz3snCjoxfvko9ou8WLmfd7+h5Xhfybe8v/KHbadpiT/OoQnYObO/0w/4iT
	 cKoprrC5H5EXXeAwZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1x43P12Jfq-00IGvC; Wed, 18
 Nov 2026 23:04:05 +0100
Message-ID: <8778a124-fac9-43e1-9519-e4de75b4ff0b@gmx.de>
Date: Wed, 18 Nov 2026 23:04:02 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Fix register corruption in 32-bit dynamic ftrace
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Sven Schnelle <svens@stackframe.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-parisc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e184f942e0933a1618f161abe672ad8a90bab529.1794672077.git.kmehltretter@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e184f942e0933a1618f161abe672ad8a90bab529.1794672077.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TmF0ODDvzmw9CN22SLnWHvIi4hpkGMC9lm/cPD5CJbDRkPzmu0A
 URpUG2+ALX5c1j3Z+xtzFuaINOS3BbPhjBHzVux0EHfPo2AYp17lFF9mlm5BIkO0r9jRVY/
 lx5cU3oiNFRt9xnqFCr8CIfjmLCKLMqJeMaUufCTJT6d799UIKfVOxmnT8K2FhC/h8Z/fxB
 vV4hrmmgr+2tmL1F1E7kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wkfXWt3hnN0=;77Ju23uEC94OU4rnGLkqTkSbNGK
 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
 fSdJSiNKzmI3m8tGGQ==

On 11/14/26 19:02, Karl Mehltretter wrote:
> The 32-bit dynamic ftrace trampoline allocates a 64-byte frame.
> ftrace_caller() saves %r26 at offset 20, which overlaps the third
> argument's spill slot for ftrace_function_trampoline().
>=20
> In the failing build, GCC spills org_sp_gr3 into that slot, overwriting
> saved %r26 with the original stack pointer. Tracing preempt_count_add()
> then passes that pointer as val and corrupts the preempt count.
>=20
> Allocate two frames on 32-bit, as 64-bit already does, and update the
> generated trampoline instruction to match.
>=20
> Fixes: 6ca6366220ed ("parisc: add dynamic ftrace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested with GCC 16.2.0 on a 32-bit SMP kernel under QEMU 10.0.13:
> function tracing of preempt_count_add(), preempt_count_sub() and
> update_rq_clock(), followed by a combined function/function-graph
> workload. No warnings or faults.
>=20
> I used an LLM to help isolate the failure, inspect the generated code,
> write the test harness and prepare the commit message.
>=20
>   arch/parisc/kernel/entry.S  | 4 ----
>   arch/parisc/kernel/ftrace.c | 2 +-
>   2 files changed, 1 insertion(+), 5 deletions(-)
applied.

Thanks!
Helge
