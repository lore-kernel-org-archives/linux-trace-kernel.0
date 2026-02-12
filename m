Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BF25782A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Feb 2026 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884125; cv=none; b=Sro7XbVE7TrQWpajzsqS4Pns/He31kHz450Ze0RwYajvS0kVTHdhm/hnNhxEhCZZPqLp7yh5ipI7wlIJaPAq1RJWzq5AgmfBe1wJzcjNjmM7TOMahRKR2Dwv4Ftn8qEMxUVaMM8fo/oRzuC5WXL+GH3HNStq1bUevIOpckCftUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884125; c=relaxed/simple;
	bh=G/xfy/Yw3aSBRYTcvSDLwFcvGpbEkfNZDAFwDFdzOso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQ0BRG+Ae2NWvB7bKSWPb0o3GgOo9yVWI5RMk0wSX+wdWgzOGyaxjBMr+LI3RE6KVpijfiPlXVAGiHx4j3u2PFs+BWr/OAOMYN2tgeINjzJMJIpWY6t1Ndxffa6O7ifD0epx5SRhk9LvCvu4+9aHmnO1ewf8lVb3NntXXVmlPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ocl8kg8r; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ocl8kg8r"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436263e31abso5564086f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Feb 2026 00:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770884123; x=1771488923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYTcCQQ+ktTucF6pos13F1p1yELwstagH4PhEGEuB/8=;
        b=Ocl8kg8rMc8Ymyd4LT+Tq+A5q0Gnn8LIl/T+C/8Nd3K7AcLH5f0lWkuOOjZvuVQFnT
         tqlPDWCWE5pn4b0DQB7RQm1dkdq66KkghTRdn+bkMzKaeEVh/lhT9+KXIMtS4NGzG9QG
         Ht+F9DH5xTtjPUGij0JNh5VdUEPz7eG5VW/X+JqXfnoftTmWIqSWuijjdVzBLr3zqSBp
         K3CnmBCDDMmQm9nSf0TQIryvQktKMyhe3tA6Exi6bV5y07TCIeUrbXiiflZtjCzfkUOB
         Caaf2aYd9fw2mRoV918+TUPRlE9SyBJt3RRaUI3ua+ZA1lCGAROIUeK9HNIZQRjNjvMH
         S6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884123; x=1771488923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYTcCQQ+ktTucF6pos13F1p1yELwstagH4PhEGEuB/8=;
        b=cKvF5yYdfni/fc4dN8aiRqVGflrL+w3xrnu3zbFDo/p+0pFkT6CmPNVJrnDfV5dFkS
         VzFz6lL6580v2h7Qt7Klmg00okLnhy/ZVlc4rv1+1G6NwljBulrnWo+BnDW4oUzW38df
         j/+kAk3HtJEXu0qg//eBVWMRMczCtRbEap7eg/zLnBKfUvnRDNquhhDmgnjh39mZM1+/
         rY01E0Wo4ci23RJs/3XoaAG8gZvZg5eGWTFwQ+i848MXu+/4ID9yq+6FxqJj5i4WscX4
         QtdEIof5DFJYTkbXxF1yxZblZ6XRa32p2fxBZ+7HpKN5bZDpmEqKW50gu8XeqTkhqOJg
         bAHA==
X-Forwarded-Encrypted: i=1; AJvYcCWK18CfYi/tm8J0PPFLVxup8NCIUFjAKTQusJfRNDKBi96NFPqs9rS35FTuXEI+SlTlqCcekwFEpphZdt1WObXEC2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwt3Em9hw9QOFcaLbkolcp28y6GrFYKtGcjhmu12qSZWDQ/PP
	7UuvWAUUYN9lYuTKL5yvjN4PrBU7Gu9AQP23fA+L/Jp5GK3/H6wA/NgOcJQW3kntdEE=
X-Gm-Gg: AZuq6aLdfMLbp5NawWmuClwzdVEMhdbLp7ryppIq0XlqANuyFi53CFxnGTKgHqNuhiz
	WHS2Zs+4Cv+qAx+5FGc3lUEACNpEfv71L2JNrBkB7YLkhUj38Lz0M4fZzSkKnRn2ys2oP3GYvRc
	PCx5lSfRMLJ5CoisjuXlTAci5XldNmf2Vz6vvepyrVl4QOXIBYnQ614RmrCY4z545Tq88LD8aH3
	IsATACSwUDeQ3+jBfOsuNr4mzQD9wnzyIC6sDMeFTla42ppQUiBX6OBJoOo0Tqh6O7UVzQ35Viv
	9HL9wzaAnEcjONItEhfNrVmDLar8TU5IkwZXzb3VpYLD/wiJA/X9ihE37TyebJyVTBZvFLL5xvx
	2GjwdJDm3F9hXe7OkovrP7AStpxbvMfpU4obtoKpsbMbA1WK0iLWNneuD7bIKhqVFmHveJLjXW1
	P/BYxRbCNq5B5mHlDbaO3ic7nq2pLB/b43JHHLo0UF99a0
X-Received: by 2002:a05:6000:2212:b0:437:707e:9f59 with SMTP id ffacd0b85a97d-4378acd8e25mr3695732f8f.12.1770884122736;
        Thu, 12 Feb 2026 00:15:22 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e38e26sm9858669f8f.26.2026.02.12.00.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 00:15:22 -0800 (PST)
Message-ID: <71ebc4fb-6992-4a15-93e3-43390f2216d7@suse.com>
Date: Thu, 12 Feb 2026 09:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tracing: Fix checking of freed trace_event_file for
 id files
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
 <20260210113427.1068932-3-petr.pavlu@suse.com>
 <20260211113752.54bf37e9@fedora>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260211113752.54bf37e9@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 5:37 PM, Steven Rostedt wrote:
> On Tue, 10 Feb 2026 12:28:17 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> The code for reading an event id currently uses file->f_inode->i_private to
>> store the value of trace_event_file->event_call->event.type, unlike all
>> other event files which use it to store a pointer to the associated
>> trace_event_file data. The event_id_read() function retrieves this id value
>> from i_private and checks if it is non-0/NULL to determine whether the
>> event is still valid. This approach worked in the past when
>> remove_event_file_dir() would set i_private to NULL for all files in an
>> event directory upon removal. However, with the introduction of eventfs,
>> i_private is assigned when an eventfs inode is allocated and remains set
> 
>> throughout its lifetime. As a result, event_id_read() may fail to detect
>> that an event is being removed.
> 
> Who cares? It's just an id. If the event is being removed, there's
> nothing wrong with still returning its id. The code currently is very
> simple, I don't want to make it complex for something nobody cares
> about.

I think one could argue that handling all event files in the same way is
less complex. It would also allow for a minor simplification where
event_callback() would no longer need to modify the data pointer and
eventfs then wouldn't need to pass it down to lookup_file() because it
could always use the default ei->data.

However, this is all minor and I can see your point of view. I'll drop
this patch.

-- 
Thanks,
Petr
