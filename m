Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC534DCC7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Sep 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451408; cv=none; b=CoTyFiNhxoFy/3G7ihOMgXXLQ99zm7+WoWFX3AsM/TI/ImgPmgoS3525AvgCYxptoEzA+XpTgLPMojjQ0/OlBsMISFnTNTDrAkNS1AixaNHAJ3XyxGJgOFpfwVkOHxqLPl6BZg9PQTdzPtX7fr3KiT35yMt6ROuNh1rtNdH1L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451408; c=relaxed/simple;
	bh=HAyjnKtvi/9tfuObm2zkDHpp1QzzxsFwzp99BfFGLs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kldBY/tjYDaE1dZU48FCRcz+RYnbLbipzgJb2dBOXwz2sHyyc1cLa769NkRKGQOFKhn6lagTgn5ORHexTaTijV7DbznSz/VMqmd7hdVgMTUBaMeKw8wnRFPl9igJKcZOKXpP6AexM4SpxN8RH9IhF08FS+Q0Uy/UwCZASsmpq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZHiZdQH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZHiZdQH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso13354475e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Sep 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790451403; x=1791056203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuUxqGLkbBPBTQWeWWQI49TvssdiYbq+74DblXsLcuY=;
        b=QZHiZdQHqp3eM07a2ytZIJSJg/2VVRp0HhrX7dC4jD+yBkCrDzDetGYs1GXEau1dUe
         6Nbtn/lYwEhLWHl7WBJIs5YcteDlFu/MDUZlRlLL9GQdqERaKdHZva0TDFF1pI3GWV5I
         s1z1UC5Ta/AZy7L/lp2QcYFifC/iV9tx4L/c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790451403; x=1791056203;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuUxqGLkbBPBTQWeWWQI49TvssdiYbq+74DblXsLcuY=;
        b=T0Xi/QqtCqFExPBDK0ZUrgll0d6yNDL9LuZGMviPzr+H15VCjuYYkzKLrXpqJV6e9p
         Zjt59l2DhfYAX18enu058x+cpawJg1f8iykvxCAdRtUodHPXoUF7afSAgTRQdlXLeoH/
         1TTEMHQgO9gni+DloVFnk9M0vrCKEqnOwo0H7RmTz/KshAuZFRjd2gt8nJnxi0PRLBlx
         Dl58p94rPntIjOURwW/xZnjIDM2Pt/glmieuF8hJgXT/KWgiIuSIoWMUjFWPT9VzUrWE
         w9sTzn7Qm/Orih2J4xxecZ3fSTPM5UbVl52J+EAXgZtwMKqESjSnxqttUqQBMOfzYOYZ
         Ruzw==
X-Forwarded-Encrypted: i=1; AKwUvByk0SlcAP6npt7v06wt32h4Nl0O1TQqgRISduicH6GtVu2673Z8XGk02kagvdbjT5qJD8xMlqQsiC4XUhIJ+dVPK1k=@vger.kernel.org
X-Gm-Message-State: AFuF++mFedMr7pd4ItemuTSR/d7VE+znWfO5d6L64/c10aaug/sgbtPB
	fpnVMajFT8aJ41f9JfbshSebp06gzXB/gUfb2oUtSBMHTu2KWC/aVTYkCZ6QGfoEp0k=
X-Gm-Gg: AYBFou35U+Y7ZiTLxOTmw++s4vBIoTGKU0qZtw2ybTdSHNmrjxYnxfrUdLOggQW5b+a
	ZWWxcjcKq4sLq7kcv6LemoZoTQpfkkT70MjwCl9vHpB3CmN97J6STOPwA7S/0f99zrHDuTv+1qj
	veI65iaPQ7wmuM8Q7Lc67oWjqyySIuazDFhnR39M7jPo9fPI0gYMEs0R4s6xGZTqgXTYKOodrZC
	yROEjUiOIuraIrlB+KesslQO44NndJBrs4lo/jrWZQ7ePBKowlT1r6uS54QS9m7g4p5bjpU1wgL
	JJ281WObzayXEnkdSpGpXathULriu2wm13DTV2pIw14FC2J8EEoWu3axvXxI9h431yytn+9Qyww
	RxDRZ4rZpDPR1heYgC6oGQSOyhTz3asCmwZD15hDPCf7+zKc3hCPufjO1feAQrTrOQ1RGaGQkdI
	UPdiGdZ/q5SJ0O81K3/IS6EpzD855qJZN1mNxRV4Tytv8YNNWuiwGPQJ6tFJ4NpBeH+KoBM2W4k
	vRJJ4XT8yXE9uz8lg78yl72JqIgdXL4Ev4P0bVDvNJlOT69EKtBNIch2Q==
X-Received: by 2002:a05:600c:468f:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49fe66f4fc6mr149848925e9.25.1790451402874;
        Sat, 26 Sep 2026 12:36:42 -0700 (PDT)
Received: from [10.188.205.27] (cust-west-par-46-193-1-237.cust.wifirst.net. [46.193.1.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06bdd11sm155186155e9.9.2026.09.26.12.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 12:36:41 -0700 (PDT)
Message-ID: <c6427104-c510-41d0-8144-174c002d1dc9@linuxfoundation.org>
Date: Sat, 26 Sep 2026 13:36:39 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: skip gcov symbols when picking a
 function to probe
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260925133558.3636030-1-eva.kurchatova@virtuozzo.com>
 <20260926213112.9f92e7958c2d12c946799a0f@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260926213112.9f92e7958c2d12c946799a0f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/26 06:31, Masami Hiramatsu (Google) wrote:
> On Fri, 25 Sep 2026 16:35:41 +0300
> Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:
> 
>> kprobe_eventname.tc takes the last kallsyms entry whose name ends in
>> vfs_read and puts a probe on it. On a kernel built with
>> CONFIG_GCOV_PROFILE_ALL=y the counter symbol gcc emits for the function
>> sorts after it:
>>
>>    ffffffff819bd1e0 T vfs_read
>>    ffffffff845013e0 t __gcov_.vfs_read
>>
>> so the test picks __gcov_.vfs_read, which is not a function entry, and
>> the write fails:
>>
>>    kprobe_eventname.tc: line 10: echo: write error: Invalid argument
>>
>> Leave those symbols out of the choice. The test then picks vfs_read and
>> passes; without a coverage build nothing changes, as no such symbol
>> exists there.
>>
>> This is the same class of problem as commit 23a4b108accc
>> ("tracing/selftests: Fix kprobe event name test for .isra. functions"),
>> where a compiler-generated symbol was picked instead of a real function.
>>
> 
> Oops, good catch! This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, can you pick this fix via your selftest tree? I think this is a
> kind of selftest fix/improvement.
> 
> Thanks,
> 
>> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Applied to linux-kselftest next branch for the next merge window.

thanks,
-- Shuah
