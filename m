Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FF47DF8B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853983; cv=none; b=c47WOSzVjoBDszwJDJoA2F1o676qNEcPsTocWyXI972ydJGOSu0Vud77GF9jtJei7hYl6QwfXB5ZPZeY3F5czXnv9wHztS6fw6C8URzG/XxiAuL67vGA9+kGVEerMCa+pcZemmiSUMXZd5FvWKngweI4P4T4JtmTonl0k18SKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853983; c=relaxed/simple;
	bh=nF+QzbQYy9tegaWBTmYwS04dI3CX2gR6KqOo1BG45Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgUlYIr+MZ9Crb9/TE8PIEGKV9mgDsV1Nu8w1jGT3h4xfhranSU3ldQmh2H/P5f77EZ6gaRJ1srJRaVyvWaWO4/VpgWZTajuPKW1UrYiihXZrje8fnXT8zjhwp2DVmtxaWJaLt7iQfuB7UGB2xF95x1K11XOGRQprH3CxIHTKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=XLFYVwR4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="XLFYVwR4"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479d85152c9so3884179b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778853980; x=1779458780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78n6hIIqbrjsCZ5N0mrmRwrAUChmHJKkHuqZGpSbxn0=;
        b=XLFYVwR4lnRjCVsDSTYSmJ+VtAK/DnYT+AyANwa4Dkg4/GvJbdKUAYy9B8B7x1Hi3s
         JeIM1Xru//qF7P7xX3UCRGbPcq1hxWib9T51RHYw9otg0o0srCoi5/70ufG/5luP+rIl
         62yBYLYkwZUZ0YO/vCcCSXyuOnY9rkdJ2H1aLNgxVZhXcWi0lIYTLHaviKcRzzFiqfzh
         DPVc3Vn9LYEcK1Mt7pVutwY8sYPHG3XXi/3bHn9wMszHYbUOb9PJlDv7x3s/xyaemvwa
         J5nXlsrw9TVtZeBVRDUs1XbhWk1RFeziELOGN3YNNd7+Z13cFXzzgH1Z7GH6CaEpEoNx
         y3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853981; x=1779458781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78n6hIIqbrjsCZ5N0mrmRwrAUChmHJKkHuqZGpSbxn0=;
        b=RdCGnWn1oCkXp2GHIMjzNZyQssMk67eSboKJC0d1dbcfTJuVSdDaoLvAeLiAxrd0fz
         /mCEVpzFuPLij1h7oeM2laRmiIalqFeJXTcOY/rtcSbK8jNVGVPFGUuquYZABjcemp19
         WbgbK2mwzzmA812mUPgScN8i/LAdIhzjrQzor6YYA4oW5xIs8dJBW7aCv3lu508mNOBb
         atht+2GC17APnLrManprcpBTLkMzUgfsqA/hwK89wnSJ6XGrP6Ehyem/OUdJIU5dTVqk
         4JaU+g/Ak7mD29CZgD8DMmNPRLSC0Ly7lmDQcallA7zKeO/8v6WTddwGVcX8qoc8/ECN
         zrmw==
X-Forwarded-Encrypted: i=1; AFNElJ/7etyL5QeZu/1VoLGL9R7pjhAchE5y92yAqi0EOKlwV2Pvc7NTkCpIXoEwrO/uCYH8LxbDLCxuNeJL+LfqPZyPQK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTIUhMSYIC2QLMjhnVxg5HowYAFqY/TUoRJaZXJKp6RHVIJNV
	iMVqFysqSQ3OlU8ZtNqQa+qVJ2SdFh7jmT5769oVxJZsEMY4eybv/+TDqKySRcidyeY=
X-Gm-Gg: Acq92OFH3KAaBf1c0reSjmqr2PO8iXk9PL0pTupJKiSglMLVwdfTK/q78X4Uz7T1MDb
	L12le4swcQnYF+XTGZITt0XB8KepBU66MQOjpfID+LieaersuJSnprK+SWsd2vI+gkfUwEAIQQp
	L37XJUMetOa4gBKRo4SVCcqI0CazgX/beCwJ6vHaUqvQiBB5MojsTB55g6447EP3+5zLbAfSAoP
	cGoJQ8gxcxnX6m6JPMgk7fyk+YL8yy0W0fXz6LEH/L8AJIN4gAd3+7l7E1iU9836C8hdWAtix4v
	bhEvakw/7QpWE4Temo50e/Q8VZ6in/O9RvWWKfb0AnA7PreuZE1RSdcvvMH1eyLk2TBakH2M0uI
	tp7jrhe2KnrfLpxdsAOWW0FISxKLK3n76uPEmd4DwA8+XEzdMdw9uh8C3v74HVaOl3AyCCNgSmI
	b50eCuG6okRfv0/pr1YbE5XBKNxnusi7BGzkeIT1a7hSBsFfK4VrfLQUiEVZs221wic+wI9HHnj
	nZ5lEYv
X-Received: by 2002:a05:6808:6ec5:b0:482:4dbd:4fe2 with SMTP id 5614622812f47-482e56c09e5mr2482778b6e.15.1778853975872;
        Fri, 15 May 2026 07:06:15 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee333d00sm871433b6e.3.2026.05.15.07.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 07:06:14 -0700 (PDT)
Message-ID: <49e77605-6227-426e-8103-329474bf88f9@kernel.dk>
Date: Fri, 15 May 2026 08:06:13 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] io_uring: Use trace_call__##name() at guarded
 tracepoint call sites
To: Steven Rostedt <rostedt@goodmis.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: io-uring@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20260515135903.2238731-1-vineeth@bitbyteword.org>
 <20260515100448.715589f6@gandalf.local.home>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260515100448.715589f6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 8:04 AM, Steven Rostedt wrote:
> On Fri, 15 May 2026 09:59:03 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
> 
>> From: Vineeth Pillai <vineeth@bitbyteword.org>
>>
> 
> Hi Vineeth,
> 
>> Replace trace_foo() with the new trace_call__foo() at sites already
>> guarded by trace_foo_enabled(), avoiding a redundant
>> static_branch_unlikely() re-evaluation inside the tracepoint.
>> trace_call__foo() calls the tracepoint callbacks directly without
>> utilizing the static branch again.
>>
> 
>> Original v2 series:
>> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
>>
>> Parts of the original v2 series have already been merged in mainline.
>> This patch is being reposted as a follow-up cleanup for the remaining
>> unmerged pieces.
> 
> This part should go below the '---'. There's no reason to add it to the git
> change log.

I pruned it.

> You should probably also state that these can now go in individually as all
> the dependencies are upstream.

I think he did, at least that's how I read it.


-- 
Jens Axboe

