Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82121A01CA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994202; cv=none; b=LzRpxwyCWv3zS3zsf5T7btumDWuKfYO6IawxENJRDTkcnnfhIHmiTxzEXZyHu5HJMfH6GG7gSLTxfwf6qX2MiKPGwP39JBf5QAGHwcFn2ixVkBXluyWIEKc+UmHtfWh3qJzuS+hxeE3+oZ0MPcacyV/YmtUxUdCfNWz0vZOV1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994202; c=relaxed/simple;
	bh=1WdMvYdJoPmD9mMn4XDK4ijpAdELRzGHP0yEkPBv5wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BplqmF0j3Vn0EWzw8voAcfYqmIaU8C2+p6YZFBkVE91ZgDU2ZdSKYKvhDRVok1qYIVJjB3uo/oXzJnZU48ibV4cZqNPFNitsiqAqfNCkkPm83m+NiaBR9z6PHvod+PAPT9bC/gz5Fd5d/zeAdbvdfXgMfeoafyjO6lj67kwcKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Za3Zw2O/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za3Zw2O/"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso198212039f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994200; x=1726599000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=Za3Zw2O/E5jIz0wAMgerVheBc3eec31Pk03gZP7HxHYJl61Ya0KTkDIlkxIXrtdYvM
         q7INNxAhBFvvCC1kCnP4MQHA6LzOlI6ysHdt3FNqPVNxBihaRGbzmeAQWofwMNV3qEGG
         E0dZsNiMbo4KBJKsfxwSqnJjhviJHQjHwwj8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994200; x=1726599000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=AdnxxUiFGz/tcOyh78Igu2r6/pC2nOBJX3cvDJ8ahpgylCKBr67WkyZsK14M3gg9ZL
         1Afgw3ablQWmzRtsfNeDyqiZsJNKO9qaEdMm2+61yDzjGj1QNtdLTP9BTHPRWq3SS/6G
         96xEsEmtsFgsPud3z/MznDR/G7BENonVSYnD/xMekJwUPQPpmY7y15zuZTNWwsP4JTu1
         IGRgC8wc8gQG0PRerCZSBknCXxSLGIqpAv74DRJwsYSOotr45EbZXf/Iy96AkPnCu1qp
         smVn4OMAVj3fZ02dUp5D8ZGOCV7GMBikLr11J8/kOKx/KXu1Fy1bI1Rkv6SGXVjVS9Wx
         ez7g==
X-Forwarded-Encrypted: i=1; AJvYcCX3xGXSN2IZUGORZAt/a5DsFPFT0QLDH282JEzyO3u8qq3gn3xvYmNhpUHW8+NYDcwHDBCp/aEuQxoatV2nszI05tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYDNbHz8fkqvLIuI7vnm9bZoLkVcWAmgp8+etP5stlKUlRmhO
	pK9AgXmyHcG3VdzgHvaLVGWFgDgJgyBke1qe+UgAxl/4qCLuutZXmUDy/wY7kXs=
X-Google-Smtp-Source: AGHT+IFkNN43djyLVohLaa+NqGwq6sV8jRgTpy0ojuQ+SqlTmPROviO2CjKjQ87t96vGQGvibwVnLA==
X-Received: by 2002:a92:cdad:0:b0:3a0:4250:165f with SMTP id e9e14a558f8ab-3a04efe9f61mr180725555ab.0.1725994199798;
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Message-ID: <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:49:58 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124541.23426cee@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I can take this through my tree.

> 
> -- Steve
> 
> 
> On Tue, 10 Sep 2024 17:23:34 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Improve the ring-buffer meta-page test coverage by checking for the
>> entire padding region to be 0 instead of just looking at the first 4
>> bytes.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend.  This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer
