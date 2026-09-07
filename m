Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C73EC2FF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796068; cv=none; b=ojwQmroczXrBw+yk0rb5QpZZxZaerrzb7AGBd4MXckxvkRdKjSaamMW2hvsxls/Vt/mt2vHmhhKeEIAba3FfSf1lByIfvlCY5SaRww67iR7DR4MPJVSlvLX7byE3lvc3TrkdGWLLT8IrmG2B4ePnYLi2uu4pqxeEfZu8hdbnHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796068; c=relaxed/simple;
	bh=LsBLn8cXF33M9xsQ1sh1/dOCqLgHSvdMJu+9kf2eJnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLgm3oQmMqXYdbd/Pz9U96pAYgnJm+Ch2RMSOX7bJLcx6w3BfXj+Nddqis3cPMhLAF9iHiM/gnze+TEIJSOmfkdvd/6AA2+VcoHLF1BuXWMQk9HlUM2lNYW1Hxrr+AQuxIYiPjHhgWjKzCKIliX5DvxY6hAcEo6VDQuAFDG3444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T5RFN9uH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T5RFN9uH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9399d52b1efso77704485a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796066; x=1789400866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQkY42FeJcZwapgA9K9xQ52KS/Gzc6p9wbLWVF1hJqQ=;
        b=T5RFN9uHYw2Gwn1xfZPr0recEXJaRsQJq2oMn+afoJGAFvweafz355lZ1QBd/sg/XH
         Ia7SxQXa8OYPcGO9/H+SgGJaN74v/eRApKiGSz+Gu0YDb1+X3BgJCFb1uxZxtfk8kVDl
         K63lHqO/JDudUoU0cAmP0D1XBHDm8HheCi6/aGnKPo5pBRVbTH3QmPJJfNDvMAB6NJu3
         WWgpQl7GajaIuY51V2tEN0bvSbxt16rHDXsqY9i7FPw+OuxdV5E10gYKV1piLFjL/IFL
         odNdcwLw8ONoTUIEM1PS9B9P2BRVNFMBMPI924qc0diYzedV8BBjDMz1ip3Fkfj2Ek9e
         KQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796066; x=1789400866;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQkY42FeJcZwapgA9K9xQ52KS/Gzc6p9wbLWVF1hJqQ=;
        b=B4ygFa+n+SNZTRBJ0Au+7CnKeqYFK2MuDn+MkNktc7KDFxd9xqA20udjvvyMbj7RMH
         sL0vAihFVZOjEVoILgB7mwaGJ+adqZLgCdgIn5umdJch/8l6aVtfvgBiZn+vBj3BbRiQ
         rQM5MzqmwBsv36XY/02ssQanzkhCuOpm706/XXimLh2WYfJ2vaES3rJXYPKtObTGMZrb
         kWcA5uKK+/YhFR5C+VxoM3fbSLymeaXrqgrhTWjrgIY3Bow9YFd1TY8j6VV8EJIk9o3o
         VCWSzRBtNEUhxYdt79cOT7jW7upisY+sBC4ap4nKlJtXTFOJnnGDliKf7QKxlZK1xlGR
         sCIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwADM2DSDZ4rQN1SiN445ebH5Qo83w2yhL9piJG6/k9h4JykbTknO+bH+UFhE0LA9F0VfPocP5NHS3OR0ksGH74e48=@vger.kernel.org
X-Gm-Message-State: AFuF++lSOgkAcXdsnSZQbaPJIc0AnJ6r+9QsxCgtoGdYmkny0aV/ggDD
	6KEYGiQGvw4nkKS4udNx8mFKEKJobmX345MQgCdcj1bC7oHOmBZR2filgchv7xLRGLo=
X-Gm-Gg: AYBFou0Wvv9ZXaYsF6SrE8ZmFG32Yq2rNNUMEAM44jUwcL8gf4zPWgIbmlbo30bkTAw
	rP9JCR7PbAow7jH3toRXIq2c+/oevDf9jXH6A8mRHLYeEaxkHqqiMvU/cwodksBPIPHVqNhM85t
	IityJtF2vCyexcSD/Bb9dC/GcgcDmnymNRHxI66i1Tv+yZ8JEiAHeyS6AflFKGHhVrlYnE2ungY
	qTLzBmfIDndQlGc/bd8kNfksf2AUHutRRSoGBlMXzhGQPKQfKXE+JSh/kdyhnes50Pu0KZzMnrB
	QJ6GgLxKry9SA8ZYT6d72Te3Q+QuyErY0e/g/RDHnSsRznKce2Y6cz9AhMgyIc/ZIbDzwcRICX7
	DDyEMHVNHUqgxDfif36gL/emYvleRxdLD4qZQpHHOC+lk+Ye6vOp3JJilFkdYAPM4B5I2hCfpqw
	iq+jigmeD7F9TEbljbnsfkuMUPJGWCtJMO9by8bziouz1Qlq9F/VtPNzsvlacZdc8aaPqM29O5I
	XyUDtVXint5xIBywB1GAc8Q4EF0L+rJYd1ymIsOBUmT
X-Received: by 2002:a05:620a:6cc7:b0:939:6de7:8768 with SMTP id af79cd13be357-939805729bbmr2426484585a.47.1788796060831;
        Mon, 07 Sep 2026 08:47:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbb70f1sm928876585a.40.2026.09.07.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:47:40 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:47:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	rafael@kernel.org, gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 7/8] lib: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7ckXealr0JMfeN@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-8-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-8-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:33PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in lib/ with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

