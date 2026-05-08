Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899732DCBF8;
	Fri,  8 May 2026 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225553; cv=none; b=EtL1elNsKhemRnBokLHTgIdEXR9D0K3ol51X9sMDz1e+tXe+wogHVFWdIBt5weZnmNZPyzWyrjdSPrB5CJ/ytSplBwsv0nd0ZJuSb0immbp7JxsyLZ4cwkYJokQHNviOuBqU8nfwTRtuioetx9hXYglLGD8gg+f8V32QvcpBK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225553; c=relaxed/simple;
	bh=AYsiXlW/teTPDMqxUGkwoBRVH4hKipyBDylTAXCLQyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rWKWsvMPdod4kh997+au0qS3Gwp7HZpIehLyU3FkixBq5m848bJRn2d9He3KW1SoQuex6EmakJY9lBVcZKNNG/KrO1Dth9EeAgGPh4ZNtRWXG0INE4r94nVpI3taIGYaSYu6fVKsOWphGOUqymRUO3Ekt8DlEgny9igpn7Ql9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=XIHfwlpr; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="XIHfwlpr"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1wLFh8-00044X-8P; Fri, 08 May 2026 03:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=WmVnip/FMKmqyeBcL7aMwieuxLuS6XeyPHj3oEAWpQM=; b=XIHfwlprrhgtTgcNIOhg
	CcBUH6+/hO1JcY6LztnSnOBfAXOAgjrp/iYX//GVA4F28+vlMTUW95DpWqC9AQTczAKS/AcuFfnv9
	ryPwY/ZX5lj/q3pXejK4fcKSY1Hsp+SH9SdfWbsZK7FU+eguoGwSzrwXPeUgApU9aWoUg7wJU7FV+
	G9MfRDIRkMttdvaeiKtNWgS5M9qi2q8OZXRGvl5QAWoF18+AHQiHpxs1QYfIACSbWb7SIqDtpmovm
	i4liRSWnKnktZVy9EsQdqqyMnY9qv36iDB4ZLHYsu24rKHDy/4rrBGBQFUTPd1WfS1jOlWOyWW5ln
	Rq0dTzA4bqWprw==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  mhiramat@kernel.org,  mathieu.desnoyers@efficios.com,
  jremus@linux.ibm.com,  jpoimboe@kernel.org,  peterz@infradead.org,
  mingo@kernel.org,  jolsa@kernel.org,  acme@kernel.org,
  namhyung@kernel.org,  tglx@linutronix.de,  andrii@kernel.org,
  indu.bhagat@oracle.com,  beaub@linux.microsoft.com,
  torvalds@linux-foundation.org,  akpm@linux-foundation.org,
  fweimer@redhat.com,  kees@kernel.org,  codonell@redhat.com,
  sam@gentoo.org,  dylanbhatch@google.com,  bp@alien8.de,
  dave.hansen@linux.intel.com,  david@redhat.com,  hpa@zytor.com,
  Liam.Howlett@oracle.com,  lorenzo.stoakes@oracle.com,  mhocko@suse.com,
  rppt@kernel.org,  surenb@google.com,  vbabka@suse.cz,  hca@linux.ibm.com,
  gor@linux.ibm.com
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
In-Reply-To: <20260507215751.0c286695@fedora>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<87zf2bl7jj.fsf@gnu.org> <20260507215751.0c286695@fedora>
Date: Fri, 08 May 2026 09:32:08 +0200
Message-ID: <873402cq6f.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> On Thu, 07 May 2026 14:37:36 +0200
> "Jose E. Marchesi" <jemarch@gnu.org> wrote:
>
>> FWIW passing start and end of both the tracing data and the text segment
>> it covers seems reasonable to me.  This covers the case in which the
>> same tracing data describes several text segments, which can happen with
>> SFrame and other similar formats.
>
> Just so I understand you. You are suggesting to pass in the end address
> instead of the length?

No no, was talking conceptually. Denoting the end of the region by its
length is better.  I see no reason to do otherwise in this case.
