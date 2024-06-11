Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010A79C8;
	Tue, 11 Jun 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096743; cv=none; b=rq52NQbBzFK5X/C4m7M6KfSC3f5A6cKR6Nx5JXlWcTnZR+CbgQ1eGVNbvllkMzGD1Pjiu/G7pkGnNgqaHZIn+TsyaYkpRK8UDK2G4G6nf+Cm+9ASxPanAr4JmqJ6VudKuyb7Y6xeuzyF6VarqgsiJpQUlxtGtKbLBAZDsM6wtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096743; c=relaxed/simple;
	bh=28AoFK179RleAe37+vqCxMapLMFcf/7yYDPj5dgjioI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5yubPCza1NsLfNc8YsGuLXnVQ0+T8mc009Vx7Y0fsmdY/RSkkGOho7/Xy4opwAbErmHTHq3PQgj2/5JKB47QokpIMeHQSQA3XP+Kr7jVPPgID3mJa8sKsmCWw30ogIOts+GrblwxR7M9I6hUTMOM9RNxtbE35eK+XgOT4Bzplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=EA5Ij96f; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="EA5Ij96f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZYiV+o9zSIIWC0OgvJkjL9fcIjrSZKa6eSjmis7oq24=; t=1718096741;
	x=1718528741; b=EA5Ij96fQh1ZQePbIJBzChkz2meSDoB7jdFatxBevmhjbi9Ij0FiJ6kuK/oeC
	9MNNPzqbd152hcynF7dy7NEzv70HbEq/mCqUSyGLwzzfcpxDhNXcWNIgDcXz8H5gvY1vwh5NW/w3K
	fE7jn8je5Hoy2T0KrXLDHEHCfrIEVTEEK5zixJDsFMGcc/JFR7bna+IrkVisyKKhg/s0NLCRgtLGj
	q1TRxUXB0OaIVzqi6slvqgkGX1biOteU6EYqYkwcBmrYA/GF+wJA5o3RLNaRorvRWz4wrZnz+u+aj
	PpwXuV6nFuen1PlOCYHghY0mB9jSbN4VeAOqMuWjP6xzu/TIig==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sGxRb-0007R9-Ju; Tue, 11 Jun 2024 11:05:31 +0200
Message-ID: <c1a562a3-40b6-4a44-a0de-72b1614d8d36@leemhuis.info>
Date: Tue, 11 Jun 2024 11:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Vlastimil Babka <vbabka@suse.cz>, Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
 <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
 <20240610163606.069d552a@gandalf.local.home>
 <70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
 <2024061143-transfer-jalapeno-afa0@gregkh>
 <05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1718096741;c2657896;
X-HE-SMSGID: 1sGxRb-0007R9-Ju

On 11.06.24 10:42, Vlastimil Babka wrote:
> On 6/11/24 8:23 AM, Greg KH wrote:
>> On Mon, Jun 10, 2024 at 11:40:54PM +0200, Vlastimil Babka wrote:
>>> On 6/10/24 10:36 PM, Steven Rostedt wrote:
>>>> On Mon, 10 Jun 2024 08:46:42 -0700
>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>
>>>>>>> index 7c29f4afc23d..338c52168e61 100644
>>>>>>> --- a/fs/tracefs/inode.c
>>>>>>> +++ b/fs/tracefs/inode.c
>>>>>>> @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>>>>>>>  	return &ti->vfs_inode;
>>>>>>>  }
>>>>>>>  
>>>>>>> -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
>>>>>>> -{
>>>>>>> -	struct tracefs_inode *ti;
>>>>>>> -
>>>>>>> -	ti = container_of(rcu, struct tracefs_inode, rcu);
>>>>>>> -	kmem_cache_free(tracefs_inode_cachep, ti);  
>>>>>>
>>>>>> Does this work?
>>>>>>
>>>>>> tracefs needs to be freed via the tracefs_inode_cachep. Does
>>>>>> kfree_rcu() handle specific frees for objects that were not allocated
>>>>>> via kmalloc()?  
>>>>>
>>>>> A recent change to kfree() allows it to correctly handle memory allocated
>>>>> via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)
>>>>
>>>> If that's the case then:
>>>>
>>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>>
>>>> Do we have a way to add a "Depends-on" tag so that anyone backporting this
>>>> will know that it requires the change to whatever allowed that to happen?
>>>
>>> Looks like people use that tag, although no grep hits in Documentation, so
>>> Cc'ing workflows@ and Thorsten.
>>>
>>> In this case it would be
>>>
>>> Depends-on: c9929f0e344a ("mm/slob: remove CONFIG_SLOB")
>>
>> Ick, no, use the documented way of handling this as described in the
>> stable kernel rules file.
> 
> AFAICS that documented way is for a different situation? I assume you mean
> this part:
> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> 
> But that would assume we actively want to backport this cleanup patch in the
> first place. But as I understand Steven's intention, we want just to make
> sure that if in the future this patch is backported (i.e. as a dependency of
> something else) it won't be forgotten to also backport c9929f0e344a
> ("mm/slob: remove CONFIG_SLOB"). How to express that without actively
> marking this patch for backport at the same time?

Hah, waiting a bit spared me the time to write a similar reply. :-D
Writing one now anyway to broaden the scope:

I recently noticed we have the same problem when it comes to the
"delayed backporting" aspect, e.g. this part:

"""
* Delay pick up of patches::

    Cc: <stable@vger.kernel.org> # after -rc3
"""

I'll bring this up in a maintainers summit proposal I'm currently
preparing. But I have no idea how to solve this in an elegant way.
"Cc: <stable+INeitherKnowNorCare@kernel.org> # after -rc3" could work,
but well, as indicated, that's kinda ugly.

Ciao, Thorsten
