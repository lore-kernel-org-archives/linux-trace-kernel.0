Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460271BC3F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765164; cv=none; b=GgHlbv5KzV8htDo51CQuVkBrkx6T+OdqeqX/9NOYKuOyIE4xPv9+ZC1KWM01jAY+b7i+1hnV5mh4Px4O5bj4/Yy2scDq+mImUqDS5IakQUxfMrGSsG6c+KeU6K2vwNjZEfbxeG3e/5wD5KctaJal/MnNf7Gzeh62CCuJhGUXChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765164; c=relaxed/simple;
	bh=R/F4w67W6cloO9uEK1AvkQr+zOFAuMuXkx1/WVMMYYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHtqfAi7OoIcNZ0Qb2+1Nu13iqmBiZPvO+2iKLN+1aQGRBKQR1UQmJKgwtBUDyqnLBV5MBxQp3SeQkz37gIXZwQb+l3jDyYWhSD4xyir00WYcSdbgNQ/hjI8LH6I5wHrBYVcIGfK7vhW2OjJKzMGkVapSIaXH+bneQf79DtGeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=T0hvhLyg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="T0hvhLyg"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512e39226efso285199e87.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709765159; x=1710369959; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqjCf0vDe5I2/zBLxS6G9LKO0E31vevuOHn3BfvEsl4=;
        b=T0hvhLygREhXyoetI+8+z7pP9263MH24QUeZMIIWh8NORy/ibcFwEWrUgCQsehdFYa
         AiF5HI1rV3h81WkAnUl9OfEuFWKr8RDztFGYeLPZTVWIFyS22NwILsa2Hb666Bcs3M4X
         5jO62Yz+qKfU5tDrsVkhzJznxBQepp9dMpCcdcTMruoAiWtWI1lXkfYzIL+xRBXYf/cs
         1G6+m4zrjCXgF5dXPSkiI8QUZbTCxtKYYq5zFb4bb9N+do7eg3Sj63s15VfuwLTNrpa+
         XKaim4heeaWpIeKsc1ALVWIHm4py2u+Lvx2pVy55C/cRRrtO2R8BnYyDUxW7LLxj/B8Q
         oMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765159; x=1710369959;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqjCf0vDe5I2/zBLxS6G9LKO0E31vevuOHn3BfvEsl4=;
        b=OyN5v4DdjSVtQUVeaxZ933aSXmXydy32/v2aec5+uLRkPm7uckUryllayV8tgYMCwL
         NdHwncadXC4s7/tb3EEGM1Q8yQalXZ9a1ThkaGmpum8iae3h0jXsq/Fmmc5uKqwmjl/5
         68aS4iUBqgrIvO8CJXeh9WflCiB9pbV2nLAcl9BNuxOUR0c5F4xnoKaUYYYVV4ZXggpy
         9FenPZysqObyq2jIuzsKT0/DLja4+EmEbnCnvT+lTGulXua9vUBVlbsakrT9bhLMG949
         /HtWmIQghbZX6CnsB8XVPF+4thKcBZepuZ10MTBMjqQdACpOMFNzIruwb7dsklda1gXt
         q9rg==
X-Forwarded-Encrypted: i=1; AJvYcCWL9B6xpk65Yf/Xgsr2CFoVdQnmTiL1wMdk2DmRv03++DKDJZdjZpfiL+XBE1qxDqyylU4xcbmNyM3d/EO983qIGHG5/bl2KAmtqRddauLWLxK5
X-Gm-Message-State: AOJu0Yz7ciBVI3nmyUOJt0rfqy2PY4sgk5ca/cDkXcUE2KwWB2PhIHD9
	sDSXatWIgT6WXSbvgizMStntkYUURO+uYAFQN0jejrrs6DKpbqzAsiFspGiwfcfCxrWhK7KQFDk
	0
X-Google-Smtp-Source: AGHT+IEgXnIPgtc5GTcWTi0c2RfSswrjuGnxmQtrEzB4m9y1lQiz8vILtoJlvkqyCH7ZbpRi7HiXhw==
X-Received: by 2002:ac2:46cf:0:b0:513:39a0:1fec with SMTP id p15-20020ac246cf000000b0051339a01fecmr223678lfo.66.1709765159374;
        Wed, 06 Mar 2024 14:45:59 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id t11-20020a056512208b00b005131cf6ea51sm2790316lfr.8.2024.03.06.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:45:58 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240306164626.5a11f3cd@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
 <87a5nkhnlv.fsf@waldekranz.com>
 <20240228095648.646a6f1a@gandalf.local.home>
 <877cihhb7y.fsf@waldekranz.com>
 <20240306101557.2c56fbc6@gandalf.local.home>
 <874jdjgmdd.fsf@waldekranz.com>
 <20240306164626.5a11f3cd@gandalf.local.home>
Date: Wed, 06 Mar 2024 23:45:57 +0100
Message-ID: <871q8ngesa.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, mar 06, 2024 at 16:46, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 06 Mar 2024 21:02:06 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> On ons, mar 06, 2024 at 10:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Mon, 04 Mar 2024 23:40:49 +0100
>> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >  
>> >> On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:  
>> >> > On Wed, 28 Feb 2024 11:47:24 +0100
>> >> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >> >  
>> >> > The "trace_seq p" is a pointer to trace_seq descriptor that can build
>> >> > strings, and then you can use it to print a custom string in the trace
>> >> > output.    
>> >> 
>> >> Yes I managed to decode the hidden variable :) I also found
>> >> trace_seq_acquire() (and its macro alter ego __get_buf()), which would
>> >> let me keep the generic stringer functions. So far, so good.
>> >> 
>> >> I think the foundational problem remains though: TP_printk() is not
>> >> executed until a user reads from the trace_pipe; at which point the
>> >> object referenced by __entry->info may already be dead and
>> >> buried. Right?  
>> >
>> > Correct. You would need to load all the information into the event data
>> > itself, at the time of the event is triggered, that is needed to determine
>> > how to display it.  
>> 
>> Given that that is quite gnarly to do for the events I'm trying to
>> trace, because of the complex object graph, would it be acceptable to
>> format the message in the assign phase and store it as dynamic data?
>> I.e., what (I think) you suggested at the end of your first response.
>
> It's really up to what you want to do ;-)

Alright. I'll interpret that as "there's a >0% chance that I'll give you
an Acked-by on something like that" :)

>> 
>> My thinking is:
>> 
>> - Managing a duplicate (flattened) object graph, exclusively for use by
>>   these tracepoints, increases the effort to keep the tracing in sync
>>   with new additions to switchdev; which I think will result in
>>   developers simply avoiding it altogether. In other words: I'd rather
>>   have somewhat inefficient but simple flashlight, rather than a very
>>   efficient one that no one knows how to change the batteries in.
>> 
>> - This is typically not a very hot path. Most events are triggered by
>>   user configuration. Otherwise when new neighbors are discovered.
>> 
>> - __entry->info is still there for use by raw tracepoint consumers from
>>   userspace.
>
> How big is this info?

The common struct (switchdev_notifier_info) is 24B at the
moment. Depending on __entry->val, the size of the enclosing
notification (e.g. switchdev_notifier_port_obj_info) is between
40-64B. This pattern may then repeat again inside the concrete notifier,
where you have a pointer to a common object (e.g. switchdev_obj, 48B)
whose outer size (e.g. switchdev_obj_port_vlan, 56B) is determined by an
accompanying enum.
