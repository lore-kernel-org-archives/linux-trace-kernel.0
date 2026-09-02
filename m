Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A833345A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319535; cv=none; b=g0kHJioWrLDE8bqbMhq35oc4Ov3MwVYHS/d10ZwVuX7IDWpzYHITAUn62MQuGjysqy57wwh2O7Q1IT/Nx5qyoHnADUY8kUM9uI2fEebPIzFKSZqk3/Q8s0udEoTtVZjykWFFctlqOvqNZsXd84w8PxXjiWp9UuZIvkbhCncYFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319535; c=relaxed/simple;
	bh=kkj1SfAuKbnUxsBGDMnYN1uaJ75fNUtFYXF6EgPIdEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwnorRXc71QBSxLtn/SoV2bkEWeflma1rGHAuC2E93sWpmIHnRwE5Ies4N2bytpYpMdA7Ra3VOn5AjKW8MqMkJR+mxWxaOeG4zNO5gsN2gJ8PrUxS9uUh8VnnLtiWZIVct5HECOn3MzBT8cvhG3LNjywsFEbFRbsaWA9SUbCaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEXjC8Q5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEXjC8Q5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so562343a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 20:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319533; x=1788924333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VD6v8s0YmmBGH+g/L9ADsNVfDz8b1jCa2DNP/I6lmU4=;
        b=dEXjC8Q5rbxnyrNdCoTWmzQAOCVqAqD9ymwSv+UY7eobXbEXvg+YmsKWC0/mVIb2Jo
         u7TLJGzdpAgyw5ZskMxNBd/A2ME0IEFj00KAY8HbpVJ7r4BTnmYHDcIPAAtYuVZ4lKuJ
         P4yjW9PI0t4Kd8uKQYruPghngfiRD2pjl4ciVTP7tsvGsJu1fLMQvmJFe4Dz2UOP9x9m
         kXQt3ajzjRHzSwcXb7hPPCB9+FeQ9H/fU+10vJNXYxjjbl3Y6VSL6UVaa9emhmbJEATH
         BYpOSzv+8/3MhDP9PfOez21Ocm1Gh3QnaWaTcKBfapCiRAOvwTsURpS5XLg6idHGzoTH
         HYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319533; x=1788924333;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD6v8s0YmmBGH+g/L9ADsNVfDz8b1jCa2DNP/I6lmU4=;
        b=XMnunyivvztowCOX5gbcqViP4oI8QU/92llNjPFXN+jIXqubY/LKHad3I/Ns+9e23S
         84ItQsNg55LSNBPxnj8Y8izHgcqf1+uZrI6E3pptAhLvp+MFi5v7gXVS8vic2DR05tnl
         ciM0sf0r4L7EEt/pzBXO0PQUqGtzi16XN5I0bYQ45MWAXRQ3MCqHLASVPSvMwctkir7S
         lmraUydq4/mHoQaFxtfGEuWkSnpZHagoY9vjOo4NNUWLpV3P+/m84rXcv/bNKvxEDeJ1
         Ae+ShFJqOmKp0hUMcoqUibqQqGWTagkD8UG/UcvSXKI0XfcY1Zd0W1K3DmrQXXK0z9o5
         CMAg==
X-Forwarded-Encrypted: i=1; AKwUvBxI4zBK7LqhB60W17s/fr1SgjMcsrwFH0vX2cZt2dFqxsv2c2P1Fc87UvDR5oMom0gXGJWGuxHhAMjyt3wBIN1KC1I=@vger.kernel.org
X-Gm-Message-State: AFuF++lZmVLDTqylMKWh0Pr6i8Rr/pIWA2HFrwStLwTN5cfb1WNqt4ho
	UfYPTLegpebd8nFeXLZDlHn4+C4eWOtLfJ+gO4cCb3obPwJLID6uoha9
X-Gm-Gg: AYBFou0HdA73zLFvBHqWD31s6L4O4K5PQrh3kSr3/831ns+GFGSXwfIHFFiJ1slSg9K
	m5U+HJs3IxfZ6EC6pVvw0NYpxTlyPNevrfDayn+WDDuIQYOSSKcsm3IQGOZrEm2pKncuSz0Kdc+
	3MGaHwl2NWjqSyw5Ojt7nDCa5R/phYgQ+nVXoMEtDeFDRcYGM+te03Xs4iPCj/EmtSt+8dn2N8W
	hJLSEHdhi9kipokDkZTYtxqoo1foh4sYzh9yuAE+pSrxhLDCJbhDOMbwOtry1jMgitzc8jp0OeK
	sbbuMdSwOhpN/y7IgQ6hBUH0Gh0yrLOIXosVtXxVNl+kbqtY4q9buNVw84CVK3ipCafy/7a865b
	KK7M3aojNRUnjgCT8FUBFlmE1nF/5qqe1Dwf6A6z8JJG5zFlYZwNMHiqNapaCYn+umDTzvgXKfV
	GCmSkPPpjsuHrC5jI7pB/ECTicTfRE1rWuSuvAPn5Z/5ltaaiuQxH+1ZH9x70zDQ5GzzCi4rlt/
	7AGvZo=
X-Received: by 2002:a17:90b:520f:b0:398:9c00:29e9 with SMTP id 98e67ed59e1d1-39aee1b72e5mr2712074a91.17.1788319533019;
        Tue, 01 Sep 2026 20:25:33 -0700 (PDT)
Received: from [10.189.137.81] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d4637a3sm8664198a91.5.2026.09.01.20.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 20:25:32 -0700 (PDT)
Message-ID: <f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
Date: Wed, 2 Sep 2026 11:25:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
 <20260901135715.4812fde9@gandalf.local.home>
Content-Language: en-US
From: Peng Donglin <dolinux.peng@gmail.com>
In-Reply-To: <20260901135715.4812fde9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 01:57, Steven Rostedt wrote:
> On Tue,  1 Sep 2026 21:46:01 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> 
>> From: pengdonglin <pengdonglin@xiaomi.com>
>>
>> The funcgraph-retval option currently records one machine-word return
>> value without considering the function's declared return type. As a
>> result, void-returning functions can produce meaningless output, and
>> return values narrower than a general-purpose register can include
>> undefined high bits.
>>
>> This series uses kernel BTF to identify the return type of traced
>> functions and to improve funcgraph-retval output:
>>
>>    - Do not print a return value for functions with a void return type.
>>    - Trim integer, enum, struct, and union values to the available return
>>      value width when the BTF type provides suitable size information.
>>    - Format integer, enum, and boolean values according to their BTF
>>      encoding.
>>    - Mark values as "(trunc)" when the return type is wider than the
>>      value captured by the function graph tracer.
> 
> Hmm, I really don't like the "(trunc)" If it's the real return type, then
> it should just print what the real size is. No need to state it was truncated.

Thanks, I agree. We can remove the "(trunc)" suffix and print the actual 
type information instead, for example:

     ret=0x5[struct:0x10]

This would indicate that the return type is a struct with a size of 0x10 
bytes.

Would this be acceptable?

> 
> -- Steve
> 
>>
>> Here is an output comparison:
>>
>> Before:
>>   # perf ftrace -G vfs_read --graph-opts retval
>>   ...
>>   1)               |   touch_atime() {
>>   1)               |     atime_needs_update() {
>>   1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
>>   1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
>>   1)               |       current_time() {
>>   1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
>>   1)   0.352 us    |       } /* current_time ret=0x69380753 */
>>   1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
>>   1)   0.937 us    |   } /* touch_atime ret=0x0 */
>>
>> After:
>>   # perf ftrace -G vfs_read --graph-opts retval
>>   ...
>>   2)               |   touch_atime() {
>>   2)               |     atime_needs_update() {
>>   2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
>>   2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
>>   2)               |       current_time() {
>>   2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
>>   2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
>>   2)   0.753 us    |     } /* atime_needs_update ret=false */
>>   2)   0.899 us    |   } /* touch_atime */

