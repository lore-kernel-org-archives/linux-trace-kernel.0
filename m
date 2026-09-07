Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D950AC37
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796042; cv=none; b=C2PvizJNbXJPm/wZEncrZsgGpJKN5byxtIr22wQYh3Ui8dNWKaRq9T1J7/ONva75RUXSNtW1YQ9VbHd+FwnNu+3DS/7JkK8IW+QDLkBpNwA2098HqXkqCYY0XD0Ce/8wCVR9PcaPm9UvpMgQ4ZfPq0p8yM63eQG7HsozyJh0JtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796042; c=relaxed/simple;
	bh=/hqGRwDn3gn18VWIUgAvVWOCvccvyWq95BKIpNRdFtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egPAyJ//EScvaZofmdyXZvILOnu1Wz5iT2gEKQgdBi+PL+96o+D10fRRCDEQzyKRQ/ttDPhMu3bTo4sQmZyiAXDjLVsZ/RgSQnLhhRchL/hW9AIuVsmW/5Y18TUh7qwwYPKyyA+OoHCMoRcP36JmxF8Kd9NGaxIviwNqz1fXLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cBK2c+zG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cBK2c+zG"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9103be3b3d9so56668626d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796038; x=1789400838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=cBK2c+zGYEBMAfyAYJS/QQdrfqd7izx/+Cg8hDXP1IONC0/uGrnS2Wo6s7Gyw03PeE
         bmy7F1sQdHddDujNvmb67dvr3s77U6jZ+JI0u9nBlughfKTWoYTJgfg/PDSCQ8m84C9J
         Hdg52YFcBmofcI5F4cLltT+Msszbmvno0MrvrR6DziA7CChNrUpzEBgBT8Tj+S366Mgh
         HsAu5NOKRTz2LqRpaA82xB3X294iKQt6TrXFv+zSiicPYXJgRrAfzLneQ3xikl9jdnOC
         5ijNYANwE5rCujgJ+U12jnsedELi7ao/rajeeB7tucCXg4C3hhaU2YFtUZ7/ycknJNIf
         6TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796038; x=1789400838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=dlDO7oOttfbv+dztpGkX1Ec28RpRpqY7bby1t3xdNMMuzUK70beT74OdhfNMi2wjo3
         n1UUN2xOkBA7I5vWD9kMgCMIfaqmTUed+ueHwhNgxDhshpOr3xnun/VX77miEJ4ayiQq
         YYgUf2CCU4FJaieGWYAHkQpu22ixMldC78/UKTklFfSM9kC/a0PRhIxPBxu0iyeugdKi
         oyv15NwPSpgD0YFxBzkWMph3Ro1xWoqUuhk6jE8Mp04aaUpoqfdj7H3WEYXgwwUKY9IU
         CEBIXKDbmqqIGwxkYBGS0IwtlBqYIOHFauSOC14s5wy6ur+H/UI+DbtCeBxAlIMc6TS1
         Wtkw==
X-Forwarded-Encrypted: i=1; AKwUvByF+gf7AbtbppjYJhohznCVcBKlm5C60nq/kYKkvt2fRSPEOvwPdPAtNgb3M+67V3PT1nU+tdo8oCvQOKYGn7ukJJo=@vger.kernel.org
X-Gm-Message-State: AFuF++m5QOXCl+e4OS755afYHOIkMU4Dwpl3e/kVh47nhs7a5J+GmOwG
	GsS3mT76N7ZobUyMe/lrCukFIRChOZEWLGSC6OWe5xZzukAFBvaH0+7PWucW+ZQHHiM=
X-Gm-Gg: AYBFou2gkaUFKmd8miC9uRCOHj2pvMfvq/mZTIQXwvzwgvvABRVgS4L18NSAARJdz8B
	Pvr8lApv3wWLvdtH1jJjhc/W59X6S7KmKaknhVOI5/taWKfLd6HSF2V0u8g5OgJjLgzPxlfg0iQ
	qbUpIxlC9u3AXQf5bwCGuCFKPSvBm2JJ8ZSYRW6Ac/Fo4I3x8z9e3rU66LPUBrRxAZr4Rt9TuSW
	dro4S9f3CfhQvzNPxL5yA1hvbMiCEM+/zDTaipZgNBy35PjrDy4/bg8e211mHRuU7vKGSGM6p3A
	3I9Bz8jZ1UoCQ4kQ+JRMsIoedCPeyBMPiK6xASgYcOnSND2LbBLdA1vEJI0nkkLAmSsqf9yJjgc
	kvzvh/de0fNUjMmIBmIML9HlkXkpLjef5znAU6X74h++gxm8GXaBInRG/doK+0E49qc3K8XVbg1
	ZTNzY0jVDiV6qWnWeiGTFcmhHTorE7j4tr/H+psi/M8e2zezOARdIZc/VohTcprRb/EhN0hvFIw
	4zwmWraqmcbK1RHNEomdjYDGAhTrkYwevPJ6ZmFBN5t
X-Received: by 2002:a05:6214:2b87:b0:910:4861:43ac with SMTP id 6a1803df08f44-910486145aemr202492056d6.5.1788796038419;
        Mon, 07 Sep 2026 08:47:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm94174406d6.43.2026.09.07.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:47:17 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:47:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, "David Hildenbrand (arm)" <david@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7cd8OigImcG6eX@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:32PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rculock() macros, which scope the RCU read lock
> to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

