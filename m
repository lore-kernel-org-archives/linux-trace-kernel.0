Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0F1E9919;
	Fri,  8 May 2026 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205476; cv=none; b=OnaySXqct1ObqJsmm0cDyEemaIsd2NgL/rnmyPnUy5fi6WkiwNYRXmsVedcxasUQbykorQ1lUKYYJrk/Ic1w674+vqWGwjsKHHPvMW1f654te4h221aQ0JjWokHHEmVfpy9KaVbMsEqZpoEe/zH/NdwWTD80QdEyeGdbqVCMG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205476; c=relaxed/simple;
	bh=zwGXJqtMHkk8wDM3+cK7itMwj27/+3er0rIv5VjVd4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfnvkW0s0ZQBTv9GxmZ2T8zApylZ8EyMF+HWmVPRsxxFGPN+cPcpj47BVMylEbZd5/Aldi+oSachKz+CRiZx4aiAlwEw0X6GhMTRFlT2ECVeQpSBfxRwFgSFHNvuKuaY9UnqlbNOzQ22wwGvEzYboj6jPhRFGQL0y2nwCw4yT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go83HwV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go83HwV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5B4C2BCB2;
	Fri,  8 May 2026 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778205475;
	bh=zwGXJqtMHkk8wDM3+cK7itMwj27/+3er0rIv5VjVd4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Go83HwV+t1wrKx4f6udHXTtBKc6dzgyqNTv4mB0Tcrh0amiPQI422QB9bQ3/2zK2u
	 m0fp71MyyMP8TvX4dMTwFBWu5nHLrsg/VFGESz+xPs/I6TocypfS0uuMX6MfNkVFBm
	 CkdQEQoJ6s2O9XC7rRdAf02Y2Tid6wS3VTsORzhLSWm3585f8eLmxc9TlCHJ9UBi5I
	 HSmzzb+kk/kibFzdghQNogQeBOjN/QAeVEWU6zjWlvrpQi9KvfRN2pqg451wE++n2g
	 5sDvJ3env5p3yBq6V0E8LHOZAx38rE3aP3FnMiIkIQQaz/LRn23Va8aqc5Ufpe+3Mu
	 1gNF8Uq3+tfAA==
Date: Thu, 7 May 2026 21:57:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jremus@linux.ibm.com,
 jpoimboe@kernel.org, peterz@infradead.org, mingo@kernel.org,
 jolsa@kernel.org, acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 andrii@kernel.org, indu.bhagat@oracle.com, beaub@linux.microsoft.com,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 fweimer@redhat.com, kees@kernel.org, codonell@redhat.com, sam@gentoo.org,
 dylanbhatch@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@redhat.com, hpa@zytor.com, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org,
 surenb@google.com, vbabka@suse.cz, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260507215751.0c286695@fedora>
In-Reply-To: <87zf2bl7jj.fsf@gnu.org>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<87zf2bl7jj.fsf@gnu.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 May 2026 14:37:36 +0200
"Jose E. Marchesi" <jemarch@gnu.org> wrote:

> FWIW passing start and end of both the tracing data and the text segment
> it covers seems reasonable to me.  This covers the case in which the
> same tracing data describes several text segments, which can happen with
> SFrame and other similar formats.

Just so I understand you. You are suggesting to pass in the end address
instead of the length?

-- Steve
