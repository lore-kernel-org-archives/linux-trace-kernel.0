Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30017994
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858468; cv=none; b=WrSlk1vb8IAjbmi6eJJ45UiJoFfEbOrtdZYlW0OSzM4hTZIyG39ewreloUMJjfi73pVQODHxsIJIXV+NjDBFt024CtybHhKm2oyhuGWnd68AHSpqMZlg81FY0kUNwdKia1RdGTVOmxgn5HeK3DXfF7ssZ7FJSYFV75yAWfSqi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858468; c=relaxed/simple;
	bh=pk77FvIoJFqOe3hjIxvi07qZKYT8KOekiGIY+FDjot4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFDQTiFuJmCQfS2bqkAKpw9MnX4ghNKxIgeCodI2HwWB/7G/KGbZ6ltWZsRzTvdmOwqAfByAqVrO5PqE1Iv81R/2KXudGtsNMpEE4SFG6wNd9B/LYYRG7sBy4PK0929gKQpIntUc0/hzmWRaZ2r/zQeoECBoCewP3WgvCqE+Y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=oM6poxbp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="oM6poxbp"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5113303e664so1084077e87.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706858464; x=1707463264; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwbUUQIVXVTz0VccesbEfswR5fbWTE4n9Q0ACHmmb3o=;
        b=oM6poxbpA4yW9dTejFrJFyJ8qo6lWEENgqfg3aCG7f2rAVcS6lvcJBr6cIhNwkGQUz
         IU+4Bgl30thRltxkz3L0LFqyKSP0mWmZTutBdw21+SnfAtb5oodChbBGER0nEae6lujC
         IKFZflJkmzQAJ2zJ7TB+w5PRJNF6hKfz1pwkQHWI1TMhhVxjIqT4sQ+WNhh/ffAl5PrC
         SbcYpkQOpwSK618/l1XosYxE9WJq3WdyguTagvlEBbN8yWqmU67Dti8umQoK8CID2qgT
         OQ77Fdwh3WgI+JtrjYPoR1mXXeKasDEm4jsvcHGk1LG3Io67vFIlrcbmbyMj6LlSaJBL
         09JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858464; x=1707463264;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwbUUQIVXVTz0VccesbEfswR5fbWTE4n9Q0ACHmmb3o=;
        b=AnEongKwrCPsP/KXrchJzqrPeso1bGpdgYCVMDwYaYOBm0laaK2oRX0YVwtPGv+bIr
         NgxjEUbRfM6NissdeCdLvaL30lG+bYg84uhp0PBV1pmfr7cl3igrTOeRXLsvq9jfIY/d
         YEDdOOWfc4GTKEu1jpwrdY0qHl/g4h9KuGLts8xhOzWq+edSz14kWz40rbtnpuS9OrT9
         H1EqVjip6sdcthX6ABm0mNV6DxIuVZPLmcZ8kJH7M9Nof02gee6IqL3jHoAYRvwkS/4A
         ZR56kAy1EU7HtZafw0q2+BzPQh//GNtRhxT6Uod5J9Xw/WjHXaDqDQv0duZeKXxSSkdR
         pS6A==
X-Gm-Message-State: AOJu0Yx07t5fy9iOclunLL7YQxTrsoM2zipWkTzGnayGA3uiYGANvd9Q
	Bod877Fz+mIXR2TCEAJQQyu1PN6v9mhancy5fyqMqOqjdGrMlHbsojgJ/VSNkWaTOs6NyNDuMR8
	k
X-Google-Smtp-Source: AGHT+IGZd22/TiTxCGbUUTtD8AI3EPo3xd9ZDSbi1WavZgWzxDLXkVe3FH1D+WHjWkFCgjA3uP+ipA==
X-Received: by 2002:a05:6512:374a:b0:510:c73:631b with SMTP id a10-20020a056512374a00b005100c73631bmr3133365lfs.19.1706858464152;
        Thu, 01 Feb 2024 23:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDttNK642bVGNWWIPtCuzxOk0LEdcayDqFGQzkpaO9ZT33Ak4k0SgSLF8HR5O+K2BS6CdYB8hNQiijdiS1nscvv5n9F8lV19mhhr35hhyvJ1gWyuoliZNSy/PMHjJfAbsUvIodlknGmPkoTlvI+I1QqCrMtEmGU0siBea5LHAL0vcjEYB7EP1wEvNNaobBPzf63EQDB/SHL4D6L2E7+/1qJhYhMKH/y27KBsEve2Cxcs8ODiiQEOBKPB8QmflEEnfis+immUGyFkaVXPlga5cC/CF85chOqTIBBptTJuEff5H5bYKDbEwF6eZgxZKwZWMH1gnhCHCORD4=
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z10-20020a19650a000000b0051129fa324bsm212280lfb.296.2024.02.01.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:21:03 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/5] net: switchdev: Tracepoints
In-Reply-To: <20240201204459.60fea698@kernel.org>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
 <20240201204459.60fea698@kernel.org>
Date: Fri, 02 Feb 2024 08:21:01 +0100
Message-ID: <8734ubtjqa.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, feb 01, 2024 at 20:44, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 30 Jan 2024 21:19:32 +0100 Tobias Waldekranz wrote:
>> This series starts off (1-2/5) by creating stringifiers for common
>> switchdev objects. This will primarily be used by the tracepoints for
>> decoding switchdev notifications, but drivers could also make use of
>> them to provide richer debug/error messages.
>> 
>> Then follows two refactoring commits (3-4/5), with no (intended)
>> functional changes:
>> 
>> - 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
>>        function to make it easy to trace all of these.
>> 
>> - 4/5: Instead of using a different format for deferred items, reuse
>>        the existing notification structures when enqueuing. This lets
>>        us share a bit more code, and it unifies the data presented by
>>        the tracepoints.
>> 
>> Finally, add the tracepoints.
>
> Is there any risk with conflicting with the fixes which are getting
> worked on in parallel? Sorry for not investigating myself, ENOTIME.

They will unfortunately conflict with this series, yes. My journey was:

1. There's a problem with the MDB
2. I need tracepoints to figure this out
3. Having a light down here is pretty nice, I should upstream this
4. Find/understand/fix (1)
5. (4) probably should go into net

In hindsight, I should probably have anticipated this situation and done
away with (5) before proceeding with (3).

My idea now is to get the fix accepted, wait for the next merge of net
back to net-next, then fixup this series so that it does not reintroduce
the MDB sync issue. I already have a version of the fix that applies on
top of this series, so I'll just work it in to the switchdev refactor
steps in the next version.

Is there a better way to go about this?

>> v1 -> v2:
>> 
>> - Fixup kernel-doc comment for switchdev_call_replay
>> 
>> I know that there are still some warnings issued by checkpatch, but
>> I'm not sure how to work around them, given the nature of the mapper
>> macros. Please advise.
>
> It's a known problem, don't worry about those.
