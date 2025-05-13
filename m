Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB01624C3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142175; cv=none; b=cOnsUHnZFhwKW4yHmy4EtcvwcPz0mHeUOBReX6DHxrIhyMxi108JQz2W1NrYHCZZsbXhMNsu179zNrgo9ABvfcq/m8LHmxk++mzzf/F4LzYBdhz+O1XwQQ4Er0dZ0bh+OU+pZdEQCXLW6MRSSbL1gPZC55pdAfSV/HxR2oiNQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142175; c=relaxed/simple;
	bh=dc1EvFdByajZoUd7bPWEy3aTiCwvIbfqMrCdk76T0rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ0cKqHuLhdFzIbuwYhIcw/YZIJUpMD7MeM+/5xIR8pjK3CT4oJTJ2Mm7uN0IZX7s2olbPh4/OPdBrm31iYeeeuTTTLe3FGF2LmmL4zg31C+qUXgbxD3885ccY0SzSOHVsS42gCAcCWBeU2nsKeFT5tGfl35IjhYq/Xe3lsZc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2B9Y93W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2B9Y93W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747142172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5lK2aUXXFM24jrUuqUNjXmhdY+CHae+0dmeoTkQXG4c=;
	b=O2B9Y93WpJWvS2pLuUNipsNPnPWMTAqLJWaG8PlG29c56RpJPcj4eoIMzMR2pgw0KsPbyW
	XzasRC5ErkbJc+DOsk6tORMKJVoTY7M/H9x4OP4jJD59pCGnS4dIX/SHKZSQiS0JAwAb8v
	Sl7MjmmCboQSRZOtU0Pm+I8cmToHPk0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-JUiFmZVdNcy0rrzRxeNetg-1; Tue, 13 May 2025 09:16:11 -0400
X-MC-Unique: JUiFmZVdNcy0rrzRxeNetg-1
X-Mimecast-MFC-AGG-ID: JUiFmZVdNcy0rrzRxeNetg_1747142170
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso42297335e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 06:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747142170; x=1747746970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5lK2aUXXFM24jrUuqUNjXmhdY+CHae+0dmeoTkQXG4c=;
        b=WfclnzcYfxWJa2iEY8ZlCA4RC7jODT8U6P4fjfAP4ieovjlDFHi0VRjU+FpgNhW2TH
         G4ITb+DuCd4ardnuA8s2/OoFjhGSjDBa5whcJVteNKvpSjrNfehkNmshsxeNeXSAiC77
         645dxagJ7vcHA6eziW4L0GgZ6+ivR49Z4ApbfLdv5n+Y0DL5XKexlUmEHsYxcmlGmHEd
         5UH7SNXGiNiKajzDuCaeNA6+Cl02fvmcA4jrhQcvqufwsQ2dBRFW43SeuZlgwTlInIqf
         f/UaejnDAVmSrX6Fqe7Dd9siRgl4aV1ndbWOf2KEBBRsH09iqJcdipWQf2ncnpEi9vXn
         8r8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkoNwd3IUo23fyjQ8WwUij484+kbSBQk6O12tUyHom3g2NElOWCrPnruz52zv1b49qKTHlZAKKviOMJwkUHWKsspI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NZMxbDxB0GeKwRcUPOeXGpuiigfo2liWfLY75GZ/zNRyNueJ
	f9Xcv5fG1bZLl9zCTGJoaz8e0DWPmqV1CmuND1eLTFneXOqI094jKlkw+KPNInWtotS8fOJEzhg
	6pZhKpwpblOjKFERWdkOuSokl7idx/vDiGFETER9yYAEVFtRSiI3s6zEEpmHUI7a7fGpc+Q==
X-Gm-Gg: ASbGncsqjcDFWCOnC/zRFLhDCtpXn6siaJcDnO6kegw3DtL2E5N13XbCiL1VtjLanKJ
	Ssy3fy2Ud/flM9+VQZa0qoQIXefGkjZ9LyRroAroIQ60ab+GmIkY/CEqY8nFc6WT3i1JWDJUaAg
	7y8Rsfolp/ElyUSetghyXj4emzPs+hMV+w+9oKi2p/kA666Vu0HZ4/dxcPG/akHTNkkxiun8U+W
	HyUwiJTKKshEfbKhrsAdOkVmuRIcLGzDwXQzrDQ37/Gm/ys9Me41FD1kA4CEK7lxlakoVOrgMfz
	NevTXDS68ckAsF+3eIb/fL/+Qpm+bEpol56PZX2O5zuFTqksQom2xOu/xGHyFApu55Ly/Ne5me1
	leg3PbUJYXrP7/TkkqO2uRVb4uNdazR04cBUSA6Q=
X-Received: by 2002:a05:600c:608c:b0:43c:e70d:450c with SMTP id 5b1f17b1804b1-442d6dbbd6cmr141286075e9.22.1747142170039;
        Tue, 13 May 2025 06:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeRzfDrwIycfq9a6Yco8QlNMnfOIsdHECdmUa8WqAn0Qia0p9wrag/isuPcxnBtSVbdOdr7Q==
X-Received: by 2002:a05:600c:608c:b0:43c:e70d:450c with SMTP id 5b1f17b1804b1-442d6dbbd6cmr141285665e9.22.1747142169593;
        Tue, 13 May 2025 06:16:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34? (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de. [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d146af31sm203932935e9.17.2025.05.13.06.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:16:09 -0700 (PDT)
Message-ID: <60b3386e-dbb1-4fe9-bc38-d62eba4d9c50@redhat.com>
Date: Tue, 13 May 2025 15:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
To: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250513122125.1617722-1-jolsa@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250513122125.1617722-1-jolsa@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: taZnPCDZ4WH1gsKzehfNs9w8YBI5q5ymRFtnEYZE080_1747142170
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 14:21, Jiri Olsa wrote:
> From: Jiri Olsa <olsajiri@gmail.com>
> 

Thanks for debugging.

> There's error path that could lead to inactive uprobe:
> 
>    1) uprobe_register succeeds - updates instruction to int3 and
>       changes ref_ctr from 0 to 1
>    2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
>       is changed to 0 (it's not restored to 1 in the fail path)
>       uprobe is leaked
>    3) another uprobe_register comes and re-uses the leaked uprobe
>       and succeds - but int3 is already in place, so ref_ctr update
>       is skipped and it stays 0 - uprobe CAN NOT be triggered now
>    4) uprobe_unregister fails because ref_ctr value is unexpected
> 
> Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
> which is the case when uprobe_unregister fails (int3 stays in place),
> but we have already updated refctr.
> 
> The new scenario will go as follows:
> 
>    1) uprobe_register succeeds - updates instruction to int3 and
>       changes ref_ctr from 0 to 1
>    2) uprobe_unregister fails  - int3 stays in place and ref_ctr
>       is reverted to 1..  uprobe is leaked
>    3) another uprobe_register comes and re-uses the leaked uprobe
>       and succeds - but int3 is already in place, so ref_ctr update
>       is skipped and it stays 1 - uprobe CAN be triggered now
>    4) uprobe_unregister succeeds
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>

If it's in mm-stable, we should have

Fixes: ...

here

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> Please note it's based on mm-stable branch, because it has the
> latest uprobe_write_opcode rewrite changes.
> 
>   kernel/events/uprobes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..84ee7b590861 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>   
>   out:
>   	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && is_register && ref_ctr_updated)
> -		update_ref_ctr(uprobe, mm, -1);
> +	if (ret < 0 && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);


Hm, but my patch essentially did here

         /* Revert back reference counter if instruction update failed. */
-       if (ret && is_register && ref_ctr_updated)
+       if (ret < 0 && is_register && ref_ctr_updated)
                 update_ref_ctr(uprobe, mm, -1);

So how come this wasn't a problem before?

-- 
Cheers,

David / dhildenb

