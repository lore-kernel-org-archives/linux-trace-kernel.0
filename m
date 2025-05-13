Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADF746E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155426; cv=none; b=ZurZVGaimGEhCKYnx6WPkrrBRylcfCWYorFgWVU7MkUdtiiDzj8eV3dTNbbP7T+AQy3IC3xBeaaDOby52QYVFGYXmZOQHVgO8mFL9u7ScRC+5hTaxZwEYMiQBKaRe4JfhESQGUPrVLI/cbr2mteUaBaF4o4bKZyYF6nINha0nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155426; c=relaxed/simple;
	bh=JWrqgbhSVjp869QlKpaF59H6vIKgWU55jf2VuycE1nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPyhOgxCSQDhw+lCHH1deapAqtsftTuqjsTkB4d7366nM6jP2OHpPw4zTfYw+BL3ymLOvKP7X4s+x/WXPPWmPx0hKi7d9Wo7hJT5WWvak5XI7W/GtS6spx9n/6NFVOSmeK4RUYKa/DVzb/v/ycdGUqeZjdsuX1ghlkdmxX607Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6Cd1ZRa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6Cd1ZRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747155423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=63WRIgDQHqTbRieYwfCwwrLx6wS523NHtWp2FK/n1Fk=;
	b=K6Cd1ZRa3aeqLecDIAwJSfjn+xdFS18rkSCg2SafLPWYMveB8cEAmJOezLYtcEIldt8z8R
	tCYH/bTM0RXy2ikVenDW2jS7oqe+i3jq+bSRCMWwhJtfpFwEnNOX67SK+Y6KhGkaz2lXAN
	43ODjQTrok2Y1JO7LcM7BEg7ir4DUpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-PGnQvp1rNqmg-N2Rz67XUw-1; Tue, 13 May 2025 12:57:02 -0400
X-MC-Unique: PGnQvp1rNqmg-N2Rz67XUw-1
X-Mimecast-MFC-AGG-ID: PGnQvp1rNqmg-N2Rz67XUw_1747155421
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso30109085e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 09:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747155421; x=1747760221;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63WRIgDQHqTbRieYwfCwwrLx6wS523NHtWp2FK/n1Fk=;
        b=gZ39KMxmVsx6PgB/+01CNFKS44qnAf6K9zJJG5Nnzo14ltM/eQdJORHxUTSEvzKJ9J
         HiecqMczeS9JEjjxK4YRuUR5QoTx9W+nLa44Zk65b9xNnTLPQy+s/PDVyKhvCLkxdY5K
         +dA9GQGuXfNjboOmugohKbsCGw0Ay5nP/21ogWWEyzdMlZHimlRuZHcbc+LH4ZAwQG81
         NME3vmfysnOom+bij3TtClvUdPKl0reGY3/DN+6Ssf+Yv66DV1V3tzD7fYpxChC39kGD
         XTMBNtNKwznczmf7bfGBzXx37gblY7CgsNjLk0nEoy9odmT300v8tw5cU99mXj2SHLR5
         Wbuw==
X-Forwarded-Encrypted: i=1; AJvYcCUuHuauBF4cCHHhiYjHOHy/lK07nodK50ZBOh4WTs5mt4AbmJAywBsmFbk3iIcVOqfYPe3IxoqjedY4x2JvOQukOYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcfPO0iRAMRVP2v3G/TD+fxYLk481PtDQZFagU0FO+fxIVsmD
	oiy3ubPEjBv30n9weC3jS3X1f0oU9G4fy7ajDfXYmG7N6tXs1NWXkdKt8OvHwH2BRbA6hiGx/JH
	K2CY/r6yrWlLnjdxaq32xSyDy3DA+ucK8ZzdpHh4VekjeuZCZF0RczbwrSK6wnh5LVn75qQ==
X-Gm-Gg: ASbGncvLlOa54TVHTitALqecEPxIFy6INNtUWnmmyG/t4COGMEXiw6ngxiH7qZM/vN9
	T/raLg+089ewhEuLnmbv0oOzQEzebDRQfzd1i0WtyATAUlZ3Sr1iL/0X6nFvCYYf1O5KhlJcd41
	I23UQf1YlPhk2KyhtOljPDF7lZhWn9AWCVknMs3aA/5+ayk7Jg3LZYrNMwGsyXk2ZReptaiPcfQ
	QOIfxuwY4jGJZzB2KJ2Dh27z30O8T9hVZTQ7Nt37QY9N5vwCiYcaHV41+iCowCJE0VHfi/vcmLZ
	sP9dsrFodDaA1rjNjKuJU5nbECd4WWB1RMfaw3nz/g==
X-Received: by 2002:a05:600c:1c19:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-442f216cf82mr334665e9.28.1747155421162;
        Tue, 13 May 2025 09:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCzyGvfwnd0ItLcTJxsBo1pzFOm+AJLTCQwg4bRjS6dNbGP6+Eir2W8mdTb6z9qn9/dq9+cg==
X-Received: by 2002:a05:600c:1c19:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-442f216cf82mr334555e9.28.1747155420830;
        Tue, 13 May 2025 09:57:00 -0700 (PDT)
Received: from [192.168.3.141] (p57a1af41.dip0.t-ipconnect.de. [87.161.175.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm172558905e9.38.2025.05.13.09.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 09:57:00 -0700 (PDT)
Message-ID: <e1d01068-238c-4fe3-98ce-5c44753b321f@redhat.com>
Date: Tue, 13 May 2025 18:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
To: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250513122125.1617722-1-jolsa@kernel.org>
 <aCNpbPuY6FI1Aiyx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCNpbPuY6FI1Aiyx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kd1xd4hfFgrjBWB9uMKg7QHVz--apHQY_zhs46P1v1o_1747155421
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 17:46, Oleg Nesterov wrote:
> On 05/13, Jiri Olsa wrote:
>>
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>>   
>>   out:
>>   	/* Revert back reference counter if instruction update failed. */
>> -	if (ret < 0 && is_register && ref_ctr_updated)
>> -		update_ref_ctr(uprobe, mm, -1);
>> +	if (ret < 0 && ref_ctr_updated)
>> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> And just in case, I agree this has nothing to do with the recent changes from David.

BTW, I stumbled over this when doing the rework.

Back then, I was wondering if this is to handle the case where 
un-registering effectively fails because someone MADV_DONTNEED'ed the page.

But, we only perform the update_ref_ctr() after verify_opcode(), so that 
does not apply.

With proper Fixes:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

