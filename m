Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364A10957
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569279; cv=none; b=k3qUzJhYLFHPvbPiDV7xbSmfLns2fHsYaamxW5csl2hzmpFm6YhMUv4Ig4p4matCpjYiUmHxktMtMGk55orzSk0qRmCKxazKNcM9wSmvtLl0M99LghOmevpYzpFVeiZ1UVaEaoaX4gbKLplHZplMYupw7RxmwR8i3/mRw5SlqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569279; c=relaxed/simple;
	bh=Z5X50pyR0wS4lIYsN0HttoXOv4LWl0AVzhpUed4BCes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9SVDlWAZQVdyjT6OKzki8sMI6DfuJn3X1KlYcUVFP7OkdzWqTtm7TfNbvGxfcIAk7hZBsUtUtA4NgFWJeKSu1uGqAnXNTIX4O6m/Kp9RC32nLMKes1MHbU1YScw9/umjhX4HAbq8hmxIR7Q/pR7zP/4o8h901aObCZ9nknQfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3DrIOfS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3DrIOfS"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b71397df721so153355166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569275; x=1763174075; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5potOoY7oJuZDgAPEu8n/B2FvMnFZR/4eU+wIwynFI=;
        b=U3DrIOfSq41Jo3yYoAQLR69+/6srBs7EQUBw3cFjNj0P+rGMxtjqXzGgxMJehgsBRp
         j+ZdYANEkArSXZNYKh5miE5FSr1n6yDWFYMjLMI+0FXvRygkV1jhMw2SmzZ1NmL6W6al
         Mw6m0eg8s+mmHZOv3rktMgjlYqLPc+yxeJQh/bWwb1VUDpgVx01UQn6x9MzZ7xUmCfGH
         ILAJlVboKdtBmlfLnZhFXbq2qfWXl749HFiPtCvOZUjR3Nh8ug8iWQthDAoExZQ29sPz
         WzsYAGzE99rqQROMErzV22Douo7fDgasIfjtTlbsOGU61teRnXsSyoBp+TLYPGP3akAK
         hZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569275; x=1763174075;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5potOoY7oJuZDgAPEu8n/B2FvMnFZR/4eU+wIwynFI=;
        b=fJSM9snZeJjmdM987boDT+aOpQnhlCUCvDI+8Jv5gS3nEq32A7chDzbC6kAdqA+dFc
         S1wk8IcYb447+EC5IOi3Vo5aPeJyLn3sBsZqhFlA6QjU5ruMlaObBdzT7jHOa6d6Tpvb
         3oriikU/hAhgPPqz5rvHUBVy+aE+7R3hPebgVc2Fm/K2ntTtqhJ/sadwEvU/icrI3Lke
         VQtq9rGAQSSIKrHv31f5efCd2WLbbwFIAZP1y1BaS2eKxJpuLbC/nqncWkGG9gqufbgx
         wwtwM3QhriCIJzpdVKhc9fY93vqsUz9UWXcSRta6xbKxdSBQUoCEG4tfMgW1PyhPqLxC
         S/1w==
X-Forwarded-Encrypted: i=1; AJvYcCVDdZZL4ATCLVLJkjlUmOvmC1m9kniLPol2E/sfw6cbMoWtWbXOFThjH0Q1ynLPmJd2CCHo+25Wx0q/WduEi3Wbx6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMppxdY+TJ04QZD5YictUpEf8LZXXiHkZ1oi3FWs5522fjbSP+
	XtaBOZP3gwDdjixVy90An9gvm7zWfn7fbCVgagGF9j2D1rzgDWp/tj1b
X-Gm-Gg: ASbGncuSvm7zygrdaUKQzJlN4fi7NGDg08cK7P1SjvW7DnIwZe0+b9H3ofGvq7p1tqw
	4sbJJxxwJv8SjDUFBEpy1bsI6lPNbbVgovk+nQVKG1BOtaGi8r5x6Ys0CJftuMIHnHOGeAImZh2
	8VjK9Vmuweaw1BzrgwwBu2HWkLikMGDayYz7uxlSK473AKS0BCGCD8pKd+yPWhYRM6HVvfZh7vy
	5CkAgAC0pPIkMTlVe8MxE4Qa/4dJPCWCfSw5l9XZR5uP3JBNUjfH+XjvVbUUZQ8cucB5OUIZnZv
	mOj55YDdQeY81FVMtwotoAnCG0Atm0+V8ZgL2/0yc63VWd3xdpuE91zUBjqQESyCqJICAK13Do9
	qKoxEu8FvCSORcOFu6oJE1baSyb5q6yxuLrQJ9ThKs6TV9aUqjWFwGbd8YtafD1xt3cLyo1OS+X
	eR7ny5ubGv1w==
X-Google-Smtp-Source: AGHT+IF8sH5AJD5BmsEI+wfEUF+AscOx+lX9t+VpBog4E5GD0fnsTzO8XVh1qgisOXry5AIp9gqKVg==
X-Received: by 2002:a17:906:ee87:b0:b6d:4fe5:ead0 with SMTP id a640c23a62f3a-b72e028a487mr148451766b.10.1762569274625;
        Fri, 07 Nov 2025 18:34:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbd1ecfsm391337166b.10.2025.11.07.18.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 18:34:33 -0800 (PST)
Date: Sat, 8 Nov 2025 02:34:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 04/15] khugepaged: generalize
 alloc_charge_folio()
Message-ID: <20251108023432.yqw7u7wnh5x3xvgh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-5-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-5-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:06PM -0600, Nico Pache wrote:
>From: Dev Jain <dev.jain@arm.com>
>
>Pass order to alloc_charge_folio() and update mTHP statistics.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Nico Pache <npache@redhat.com>
>Signed-off-by: Nico Pache <npache@redhat.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
