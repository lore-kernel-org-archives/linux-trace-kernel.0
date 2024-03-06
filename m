Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46581140E29
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755333; cv=none; b=BOpvKrGiP1iCeQbAuk6A5xxQRYfQZ1KOO+FEAu9+8elrb7+4yN/kJsEHtWuvuYtJqFw2kA/dLONoYoE36ryGDmh1bpa2eQqEog5dxPFLiFn/VPIZQeMTU3LwEZwT5BFoquuvtBtvgJpiqg3axkySjBrydZFx9ttYL+JaeUwkxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755333; c=relaxed/simple;
	bh=j+Z8eV2Ad17vD9BNn3ZEokhmshK7uIW9xSUxhkncv6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDusiJ15DGXO9myyOKjrqzqBTrcyVqEYVJAOZZeOv13F2SRJcq1F83pEUb7kzF1cswJH25Fn/S52Hj8JbssY3cOCcmUe/s0S5QPcq4/MEvpuP7phimg9DwaXgIOct7+0Va8nkj9OY85V/pb5AzkPHTOqHVs6eCWNxxh5rPDY/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=poo9N2WI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="poo9N2WI"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51364c3d5abso83911e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709755329; x=1710360129; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXY6Xh9pDzPIu4VWiSWL9VM8zgGbBQy5cbJZfmP2hk=;
        b=poo9N2WIkSqOS689oVLx7DEOo/cqNvqoE7ot0YdFvEnp0s2lJ3TK/qPUXC+5VfCBan
         H2VFIMrvRmEnVpzCuWcJG0+DZ4shC58Z6E7dVOJmSzdzuaocDDlO6iPJS3ML4sn8xdPr
         6hMdBypfBwyIDGRetzqVxc7rgSGOHeXUkGRubX8HTZDUytAU0ZvjMJ+Z40aQzrzMX+11
         drZ84IREal7uaJV4wUL6GuwAAsGN1hQV2HB1M9Y3gjrejRjgabobukW86yMjkr53pKnz
         /ngI9SrGzXYYzvNJS0lQDZLOKLhT9955E1tuDt7Do0jUiKG1O3Yy2wWamIrtk5lAnDH7
         pxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755329; x=1710360129;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXY6Xh9pDzPIu4VWiSWL9VM8zgGbBQy5cbJZfmP2hk=;
        b=xF6RmspyyRGJPLzXhSab1cxntmwxmwjKBXtsguQqHUx33m6TIb1ohmx2ie/xqI7Med
         Zv5teh3TrKYjztRNchJFBkdNsmipBTsmlnqjbbPDhJ/Xr6rFHdLmlE3+QzVkaY0fex1I
         SCtDFN9aQqOSB4ALDZtk1wqSnBD4GTKTNYKTCLphSRDmQtgRV4i9tFx/ZOsepClzvlK5
         2AiAmHqHWQ2xIX5EnGFsLwYs9rNo3En2Of41Xs+QJIM67xLsL6YUBQfWkYWu2yLrydu+
         yv0/EAfyLiQKWlMO9XWKNGZ7qSfuDSl7juNitFD7lbzXmAizzjX+mrGnpifTt6vasNl1
         g/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+LMHr4Qzgw6PyughozvVkkf3L3gVcTCl2DPOpDh+iAF1jXz3hQkYSIv/GqHs1GE5Povntj3dxxE9MflQJ+RRIF8X+AwVv1vzLfhtqsT6l1TT
X-Gm-Message-State: AOJu0YwY5Jw3PTSRcQSy53zhxC5y6UMZKKMW5bgjXb5Bzrij8TtpWeXH
	0EMXYlO8aa5iRf9TEOXlQlfrjgmmrn8nkYh3fV1/6AEOsLZ4HAXdg8ZeRcAMLGYsG0PgP5mwEBC
	q
X-Google-Smtp-Source: AGHT+IHoRs6YNdDZM2DtOtbQ5KJZaDe+eAr2vwjc4MVHxDWNhaSnPPnr3Xw6VshITVo4qSpAtd4PMg==
X-Received: by 2002:a05:6512:4db:b0:513:597a:c60d with SMTP id w27-20020a05651204db00b00513597ac60dmr111280lfq.22.1709755328635;
        Wed, 06 Mar 2024 12:02:08 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b005131914f680sm2726264lfr.189.2024.03.06.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:02:07 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240306101557.2c56fbc6@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
 <87a5nkhnlv.fsf@waldekranz.com>
 <20240228095648.646a6f1a@gandalf.local.home>
 <877cihhb7y.fsf@waldekranz.com>
 <20240306101557.2c56fbc6@gandalf.local.home>
Date: Wed, 06 Mar 2024 21:02:06 +0100
Message-ID: <874jdjgmdd.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, mar 06, 2024 at 10:15, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 04 Mar 2024 23:40:49 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Wed, 28 Feb 2024 11:47:24 +0100
>> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >  
>> > The "trace_seq p" is a pointer to trace_seq descriptor that can build
>> > strings, and then you can use it to print a custom string in the trace
>> > output.  
>> 
>> Yes I managed to decode the hidden variable :) I also found
>> trace_seq_acquire() (and its macro alter ego __get_buf()), which would
>> let me keep the generic stringer functions. So far, so good.
>> 
>> I think the foundational problem remains though: TP_printk() is not
>> executed until a user reads from the trace_pipe; at which point the
>> object referenced by __entry->info may already be dead and
>> buried. Right?
>
> Correct. You would need to load all the information into the event data
> itself, at the time of the event is triggered, that is needed to determine
> how to display it.

Given that that is quite gnarly to do for the events I'm trying to
trace, because of the complex object graph, would it be acceptable to
format the message in the assign phase and store it as dynamic data?
I.e., what (I think) you suggested at the end of your first response.

My thinking is:

- Managing a duplicate (flattened) object graph, exclusively for use by
  these tracepoints, increases the effort to keep the tracing in sync
  with new additions to switchdev; which I think will result in
  developers simply avoiding it altogether. In other words: I'd rather
  have somewhat inefficient but simple flashlight, rather than a very
  efficient one that no one knows how to change the batteries in.

- This is typically not a very hot path. Most events are triggered by
  user configuration. Otherwise when new neighbors are discovered.

- __entry->info is still there for use by raw tracepoint consumers from
  userspace.

