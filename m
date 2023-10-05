Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED522AB53
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OFsxPyOV"
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873B25244
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:48:27 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3513e84eb65so149105ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696517295; x=1697122095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjHw1y3YE+Sfq180nstROrChF+ZzPDAn1AOFQ+gvv7o=;
        b=OFsxPyOV3ICqqKGVZ7EEPW7478okfxMhQPQ/h9SMcyXZ8TBgvg55go+dyGcvtl7rx2
         ZVGRtLvL5xFsvPZpTfDMHjxad+FlRNCIxTRRO7W2zNmIoUxHZI+PHaLKF7KDCbA/MS+w
         CXUPC77ZBUJk38qFN0Xb48+0ObPQf7+465V/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517295; x=1697122095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjHw1y3YE+Sfq180nstROrChF+ZzPDAn1AOFQ+gvv7o=;
        b=BzntaQdvah4KsvNJ8SI8qm+0GAvLYk8HnMKfKvlLIzAsT7DEiT1RCFjIKYLfVCwBbT
         RksKpNTEJZYHhwUtGBwkJL9oU0mdMinTJ2yDZ/z/0Sj8UpHWixL9IvpMmt8HxrEuCWbT
         oKFWE4Jn9lmCvqUonndIAkj92D5KTu9GpDGjcpSFYVO8S1RksDSrMfqC5pk15pQu4yy6
         AO7kI1IdJFx5JSHxNz+0ybib4Tm6lm9Ugyxpr1At8F/GuFKvnMIlO1+WCF60nRZP9UsN
         s16b/jOLi04IYf7wLfk3WvnfT1YDSNiHdh8dnQx3bl1t297wlrIWoikx0mkCYruqPl9N
         dUvg==
X-Gm-Message-State: AOJu0YxOo1B84XaAupqnTKk8McZM0LD6+f1owlPar51FK6ZKRAheba5u
	TnBlhESBE0vu/J+L6w4DphxwRA==
X-Google-Smtp-Source: AGHT+IHKSQURQp59YhmfaXMmL8a2vSGdKH4EMBlgi5ga9PQLJn1Cx5HxXwvaQcupr5NVJbtw98NqjA==
X-Received: by 2002:a92:d1d0:0:b0:351:54db:c1bc with SMTP id u16-20020a92d1d0000000b0035154dbc1bcmr5241583ilg.0.1696517295528;
        Thu, 05 Oct 2023 07:48:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056e02014900b0034f7e365f97sm466291ilr.2.2023.10.05.07.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:48:15 -0700 (PDT)
Message-ID: <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
Date: Thu, 5 Oct 2023 08:48:14 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, cleger@rivosinc.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
 <20230925230829.341-3-beaub@linux.microsoft.com>
 <20231003205908.391d17f5@gandalf.local.home>
 <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
 <20231004111437.47c80c81@gandalf.local.home>
 <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/23 10:38, Shuah Khan wrote:
> On 10/4/23 09:14, Steven Rostedt wrote:
>> On Wed, 4 Oct 2023 09:10:52 -0600
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> On 10/3/23 18:59, Steven Rostedt wrote:
>>>>
>>>> Note, this doesn't seem to apply to my tree so I only added the first
>>>> patch. I think this needs to go through Shuah's tree.
>>>>
>>>> -- Steve
>>>>
>>>
>>> Yes. I sent a fix up for rc4 - I can pull these two patches into
>>> linux-kselftest next
>>>
>>> Steve! Does that work for you?
>>>
>>
>> I applied the first patch to my tree, I think the second patch is fine to go
>> separately through your tree.
>>
> 
> 
> Yes I will apply this to linux-kselftest fixes branch once my PR
> clears.
> 

Hmm. Which tree is this patch based on? This doesn't apply to
linux-kselftest fixes - I thought this was based on top of fixes
since I sent in a fix for Linux 6.6-rc4 for user_events

Beau, Please rebase to the correct tree/branch and send v2 for
this patch.

thanks,
-- Shuah

