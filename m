Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEA29B79B;
	Thu, 19 Feb 2026 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537976; cv=none; b=dU9KFcRMglQv2L1nEgd+WLJ0KJfk/bLI4U5GgpxNYinSO32dXbz25xDNU8stGYHSIp762/wati63iVNxMjIOiiqjwEdmyc0mX4xQz60e2Ron84IDFijI5O0axCOMBM6uu+l836l/LKHxZAsf7OjBRwQRMmsFCeuAoKA4LgIogZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537976; c=relaxed/simple;
	bh=MK/lDGoEFmPcqX59Eh54A6hLN1qPbws3ioviUnAqI0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YY8Be6nvjINu15gJggaKptVyTSKqi/C7rsPTmjPYGto+c06jcsc7wkqySTfqDoYwUVgYuUnbM6ofHAjUVVWaLN8Hqph2TdYT11mmf34puXQzSPRpuFZxzP1ShIPLXKWmmJqsG1UgNC3qbCUVPfh3CRkqJzT3k9ryodp1jkPkguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QPZljZ3G; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QPZljZ3G"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61JLpje2507224
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 19 Feb 2026 13:51:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61JLpje2507224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771537906;
	bh=MK/lDGoEFmPcqX59Eh54A6hLN1qPbws3ioviUnAqI0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QPZljZ3GXv3+FCZ5/BN16BstYGCS0+tGKTC4/2UdFbJKj3IkESFuhSiGJRBpc3Xyd
	 ACySosGDDdg619fNzYUJE5/iIU0VVIiI4BbxO3s3OUyVDS72uY0LEm9OlvHlID2T3x
	 YRzT9iLHMC0FMk9GpNi0jKQf7qxvS4dOwb6YQff84b2SQrOvslGdthj0fyDRXgVg6a
	 YM4rZgTahX/zEeqx31rRbClTwRiJBn2obvgYma3E2qmLx8kkQt+JqeQN/AtYzHZuNA
	 OBCPYF1RTD0rpmIsxgM2Q3GXwB1t2tuK1S3qDl59grQAJ9l2el2jHV5xQF+cqcErR2
	 lqStBN4GwjyRA==
Date: Thu, 19 Feb 2026 13:51:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>
CC: "Elly I. Esparza" <ellyesparza8@gmail.com>, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Naveen N Rao <naveen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
User-Agent: K-9 Mail for Android
In-Reply-To: <20260218153244.GG1282955@noisy.programming.kicks-ass.net>
References: <20260218144735.24307-1-ellyesparza8@gmail.com> <0c5396b5-f084-4ade-adc9-029037031eea@intel.com> <20260218153244.GG1282955@noisy.programming.kicks-ass.net>
Message-ID: <218072EF-9D35-4D5F-8379-3B195B06A697@zytor.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 18, 2026 7:32:44 AM PST, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:
>On Wed, Feb 18, 2026 at 07:18:25AM -0800, Dave Hansen wrote:
>> =2E=2E=2E adding kprobes folks and Kees to cc
>>=20
>> On 2/18/26 06:47, Elly I=2E Esparza wrote:
>> > Kprobes can be used by rootkits to find the address of x64_sys_call()=
,
>> > x32_sys_call() and ia32_sys_call()=2E This in turn allows for the roo=
tkits
>> > to find an specific syscall handler and hook it=2E
>> >=20
>> > Add x64_sys_call(), x32_sys_call() and ia32_sys_call() to the kprobes
>> > blacklist=2E
>> I'm an occasional, but not super regular kprobes user=2E Is this going =
to
>> hurt folks who are legitimately probing the syscall dispatch functions?
>>=20
>> I'm a bit worried that the rootkits will just move on to something else
>> and this will become a never ending game of whack-a-mole where half the
>> kernel needs NOKPROBE_SYMBOL()=2E ;)
>
>So I really think this should be noinstr; pretty much all the code here
>is noinstr already, so why not include the syscall dispatch=2E
>
>Better still, noinstr ensures the spectre-v1 mitigation actually works=2E

Yes, and merging the x64 and x32 dispatches into one function actually ena=
bles a lot of code sharing=2E
