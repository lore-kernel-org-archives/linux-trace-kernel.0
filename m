Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31434257C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:38:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B3A4E5;
	Tue, 26 Sep 2023 03:38:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429D7DA7;
	Tue, 26 Sep 2023 03:38:55 -0700 (PDT)
Received: from [10.1.36.17] (e133047.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E663F6C4;
	Tue, 26 Sep 2023 03:38:15 -0700 (PDT)
Message-ID: <efe41cee-42dd-290f-9ec2-ac002e2ec34e@arm.com>
Date: Tue, 26 Sep 2023 11:38:14 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tracing: document buffer_size_kb more precisely
Content-Language: en-US
To: Zheng Yejian <zhengyejian1@huawei.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
 <a1ae1bc0-0677-8284-9f18-1171e1dcb175@huawei.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <a1ae1bc0-0677-8284-9f18-1171e1dcb175@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/09/2023 12:44, Zheng Yejian wrote:
> On 2023/9/25 18:02, Christian Loehle wrote:
>> buffer_size_kb no longer shows the requested amount, but the one that
>> is actually used internally for the ring buffer.
>>
>> commit 6d98a0f2ac3c ("tracing: Set actual size after ring buffer resize")
>> changed the sysfs behavior such that value read will always show the
>> actual size, while previously it showed the size that was requested
>> through the sysfs interface, even if it was rounded up to fulfill
>> the request.
>> So the documentation can state that more precisely now.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   Documentation/trace/ftrace.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>> index 23572f6697c0..2e066b3b6edc 100644
>> --- a/Documentation/trace/ftrace.rst
>> +++ b/Documentation/trace/ftrace.rst
>> @@ -191,7 +191,7 @@ of ftrace. Here is a list of some of the key files:
>>       A few extra pages may be allocated to accommodate buffer management
>>       meta-data. If the last page allocated has room for more bytes
>>       than requested, the rest of the page will be used,
>> -    making the actual allocation bigger than requested or shown.
>> +    making the actual allocation bigger than requested.
> 
> Hi, the actual allocation should still be bigger than shown due to the
> loss of accuracy when doing unit conversion from bytes to kilobytes (see
> tracing_entries_read()).
> 
Right, the sysfs obviously only allows for KB aligned setting, but you're right.
If set on the cmdline non-KB multiples are possible and accuracy is lost.
Nevermind then.

> -- 
> 
> Thanks,
> Zheng Yejian
> 
>>       ( Note, the size may not be a multiple of the page size
>>       due to buffer management meta-data. )
>>   
> 

