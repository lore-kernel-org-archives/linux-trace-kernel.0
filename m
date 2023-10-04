Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5C19BDC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:38:54 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABBA7
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:38:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35291dbf7efso30275ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696437529; x=1697042329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGk4OygiRC4+9EnUwXytnNTCJzDue1dLt499Je8Nhm4=;
        b=cWF5Hn1k1oRtPOwEOGRI/hzYgx+vFF3/dy1XTDzG4Pl2GfgYsN4EpqO28WgB0JpMiU
         QYWKx+Pyh0qpvhgfsxS0RkijrOwXn4R0kkJc3fJQItoNPqWSzGGwfLF3UzYD4O+PBZ8r
         Xm5nIQ+GA1hJxFc+p5em46NmQ9ISI+pSRrilQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437529; x=1697042329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGk4OygiRC4+9EnUwXytnNTCJzDue1dLt499Je8Nhm4=;
        b=T63rMpWCZypGtKLe9NQggeQ0bQZ6CeKvsrCJwwbP9QkiDn653woGFIGdIyJI/mFtoi
         sI22DOMouwc+Omu+n2qCTFJtXpUfT+WQieZ6kWGTE7xB3vBlncHhQk8TpcMiJ90Ms5ip
         2Z5xVglX8WVJxdUop98eA6RlcBSma+VWYWktnfz7odYABcCUxzzxJNhwZrWVnAVBd20K
         g+YKXYliMetZ2I7HNbO2I5Cv+qH3KfMIZL4z6ebPkg2PcjIPZz3aEXphgjd03MviAQPv
         kyRFEweVDuJXq6GNi64f3ymkMmqwC5rsLc4zHRb7D6Fr3xTeEa1gFQWnS7VbIm/CUVSS
         4GHQ==
X-Gm-Message-State: AOJu0YzPqMubR3yPtAS0OslA4Xb730D7VnBdSxq520XFsvpAjxAWLqZF
	JpLBvhsNwQrzC5YrKTkbGXTseQ==
X-Google-Smtp-Source: AGHT+IENPHYySv5Kh5MjoQRAQmmVHJ9bE59p45Yzdue9AOoI7LQyNhgRZcRxILlPOTiWQlZwJqu43w==
X-Received: by 2002:a92:dcce:0:b0:351:54db:c1bb with SMTP id b14-20020a92dcce000000b0035154dbc1bbmr2957911ilr.0.1696437529374;
        Wed, 04 Oct 2023 09:38:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a92ce82000000b0034ff58af12dsm22584ilo.77.2023.10.04.09.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 09:38:49 -0700 (PDT)
Message-ID: <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
Date: Wed, 4 Oct 2023 10:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 cleger@rivosinc.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
 <20230925230829.341-3-beaub@linux.microsoft.com>
 <20231003205908.391d17f5@gandalf.local.home>
 <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
 <20231004111437.47c80c81@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231004111437.47c80c81@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/23 09:14, Steven Rostedt wrote:
> On Wed, 4 Oct 2023 09:10:52 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 10/3/23 18:59, Steven Rostedt wrote:
>>>
>>> Note, this doesn't seem to apply to my tree so I only added the first
>>> patch. I think this needs to go through Shuah's tree.
>>>
>>> -- Steve
>>>
>>>    
>>
>> Yes. I sent a fix up for rc4 - I can pull these two patches into
>> linux-kselftest next
>>
>> Steve! Does that work for you?
>>
> 
> I applied the first patch to my tree, I think the second patch is fine to go
> separately through your tree.
> 


Yes I will apply this to linux-kselftest fixes branch once my PR
clears.

thanks,
-- Shuah

