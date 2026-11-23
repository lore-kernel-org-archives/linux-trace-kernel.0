Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471003;
	b=Y5MkeXoPDFt8g8rTF6QTIUqW1zA8Dx1ZEEjoOQk87pyQ1q7+b6dNmSZ9480JoAgEfUJH
	 dNehxFBT83AXVBLklFwANMI4A519h7iFr4493vUWNVJbr+vMfDq0SjQfWkPmp1vhGdZPw
	 rw3FiKMKOLN8oQuHUMirQfDJNYn906BbAqMSgJt9UWRFIuGlAloC/6kY6ITx5Ny/C58Z+
	 u7DjhcgH6zQnpioyOXvecOh9ufUiPpifFQWN3CuMwKrXcy1ylZtbY60mH/OmoJJ12O35w
	 0reBAcxcPZWX/Ov6cvfhykNjMRzd33MORXiXJKACXBgswApjjX2e7ugD+dFYswacRbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471003;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=se2Dv26Z/48b9YJDecdodAx/gKOEn8umjmUKLpeNdcE=;
	b=Dro1AoBulFQxoWKCHTXbCe5QQ9ZXlLjBSSaz0K0ADKtfkPebH6nf+O1aTOxnhizW9pxr
	 KULftUjXwZ5HV9NqRAU5qN/uwzY9b6suzwwETNawWTI+QOhkpCeunf94Ceeeo6zrFvExV
	 VB8t4cULeFhkIXwESBejHiZIjqU/Vs+RnvBYWrhKlvYJRd0+7nUgmyEOE0fPg90MxUMQL
	 UWJLkiKKbsCJ/64zvQRqZjdXTmbNNsukaBTHjZ6vUKfnEBH9hBgAAYXNJV0wiL9T4ZBnr
	 1HLToG9dH+bqvJR0EJPWwWE5MuCxMbAzLcTEKmavyyAJKQv5Cay1hJvWSPWLgSGxm5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=W+34totZ;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC2606A31E;
	Mon, 23 Nov 2026 21:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81BC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=W+34totZ
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B0CC1A8676;
	Mon, 23 Nov 2026 21:56:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7C94520010;
	Mon, 23 Nov 2026 21:56:38 +0000 (UTC)
Date: Mon, 23 Nov 2026 16:56:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: mhiramat@kernel.org, shuah@kernel.org, mathieu.desnoyers@efficios.com,
 reddybalavignesh9979@gmail.com, richard.weiyang@gmail.com,
 michael.bommarito@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing/user_events: Share event state with
 existing threads
Message-ID: <20261123165632.2c8ee68c@gandalf.local.home>
In-Reply-To: <20261006164720.3940272-3-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
	<20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
	<20261006164720.3940272-3-jeffbarnes@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7C94520010
X-Stat-Signature: 6sa3ug34qu5mdm8ksdka44npyc15x34t
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uBX6/3tbn76JHR3U5aQYtJrpJS9Koy88=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=se2Dv26Z/48b9YJDecdodAx/gKOEn8umjmUKLpeNdcE=; b=W+34totZkPIIsNWWYcmmOVB17FzfxSGPV1pqe/pEVdZWKOWqsaOFSQ/dBRKzfmu972RTG01JhMYUHqaUiOfeoW+I61nooD5LmoynGjsx0cEIXOQq2B9MFOEyBqvvixWXabTav8lk2O8+ckxk/KUAuSCEit70OysErm5NvJwmD08=
X-HE-Tag: 1795470998-466939
X-HE-Meta: U2FsdGVkX1+RoU68q4rtQsUxPbFc20Cs6LH5N7dhfrhJtss/kxET501XK/uyQwS5wCFTShkk5qjJpPgY8n+Hvc0W6bilHo7m2c4lcYgzInhZ4P+rcRlrOXrZJJCMAAj74QXduUtAgJ3ieny6Rklvefr5Koqv8Xrm6b68XeW9GoJJE5UCaZzWdTkUSicbbBRihEjCmU6DhkPfmUWH+qBTs7n6gnEZQgs+aphWfE1a0y6KQ9+4Yd+J0X68NWldCEUXZ/42JSioTm8n7cqR/JmH1NM6/X7hR7nRW4MpDt94HzzWPO3qMkVYlDJ7xWfk7sk5msyBKTGzjQJudB065Xv2AEBiSash9WNa

On Tue,  6 Oct 2026 12:47:19 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

>  static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_struct *t)
>  {
>  	unsigned long flags;
> @@ -817,14 +831,18 @@ void user_event_mm_remove(struct task_struct *t)
>  	might_sleep();
>  
>  	mm = t->user_event_mm;
> +
> +	spin_lock_irqsave(&user_event_mms_lock, flags);
> +
>  	t->user_event_mm = NULL;
>  
> -	/* Clone will increment the tasks, only remove if last clone */
> -	if (!refcount_dec_and_test(&mm->tasks))
> +	/* Clones and attached tasks increment this count. */
> +	if (!refcount_dec_and_test(&mm->tasks)) {
> +		spin_unlock_irqrestore(&user_event_mms_lock, flags);
>  		return;
> +	}
>  
> -	/* Remove the mm from the list, so it can no longer be enabled */
> -	spin_lock_irqsave(&user_event_mms_lock, flags);
> +	/* Prevent new tasks from attaching after the last-task transition. */
>  	list_del_rcu(&mm->mms_link);
>  	spin_unlock_irqrestore(&user_event_mms_lock, flags);


Actually the above can be written better as:

@@ -832,26 +832,22 @@ static void delayed_user_event_mm_put(struct work_struct *work)
 void user_event_mm_remove(struct task_struct *t)
 {
 	struct user_event_mm *mm;
-	unsigned long flags;
 
 	might_sleep();
 
 	mm = t->user_event_mm;
 
-	spin_lock_irqsave(&user_event_mms_lock, flags);
+	scoped_guard(spinlock_irqsave, &user_event_mms_lock) {
+		t->user_event_mm = NULL;
 
-	t->user_event_mm = NULL;
+		/* Clones and attached tasks increment this count. */
+		if (!refcount_dec_and_test(&mm->tasks))
+			return;
 
-	/* Clones and attached tasks increment this count. */
-	if (!refcount_dec_and_test(&mm->tasks)) {
-		spin_unlock_irqrestore(&user_event_mms_lock, flags);
-		return;
+		/* Prevent new tasks from attaching after the last-task transition. */
+		list_del_rcu(&mm->mms_link);
 	}
 
-	/* Prevent new tasks from attaching after the last-task transition. */
-	list_del_rcu(&mm->mms_link);
-	spin_unlock_irqrestore(&user_event_mms_lock, flags);
-
 	/*
 	 * We need to wait for currently occurring writes to stop within
 	 * the mm. This is required since exit_mm() snaps the current rss
>  
> @@ -894,11 +912,25 @@ static bool
>  current_user_event_enabler_exists(struct user_event_group *group,
>  				  unsigned long uaddr, unsigned char bit)
>  {
> -	struct user_event_mm *user_mm = current_user_event_mm();
> +	struct user_event_mm *user_mm = current->user_event_mm;
> +	unsigned long flags;
>  	bool exists;
>  
>  	lockdep_assert_held(&group->reg_mutex);
>  
> +	if (!user_mm) {
> +		spin_lock_irqsave(&user_event_mms_lock, flags);
> +
> +		user_mm = user_event_mm_find_locked(current->mm);
> +
> +		if (user_mm) {
> +			refcount_inc(&user_mm->tasks);
> +			current->user_event_mm = user_mm;
> +		}
> +
> +		spin_unlock_irqrestore(&user_event_mms_lock, flags);
> +	}

and this with:

@@ -919,22 +915,17 @@ current_user_event_enabler_exists(struct user_event_group *group,
 				  unsigned long uaddr, unsigned char bit)
 {
 	struct user_event_mm *user_mm = current->user_event_mm;
-	unsigned long flags;
 	bool exists;
 
 	lockdep_assert_held(&group->reg_mutex);
 
 	if (!user_mm) {
-		spin_lock_irqsave(&user_event_mms_lock, flags);
-
+		guard(spinlock_irqsave)(&user_event_mms_lock);
 		user_mm = user_event_mm_find_locked(current->mm);
-
 		if (user_mm) {
 			refcount_inc(&user_mm->tasks);
 			current->user_event_mm = user_mm;
 		}
-
-		spin_unlock_irqrestore(&user_event_mms_lock, flags);
 	}
 
 	if (!user_mm)

-- Steve

> +
>  	if (!user_mm)
>  		return false;
>  
> @@ -906,8 +938,6 @@ current_user_event_enabler_exists(struct user_event_group *group,
>  	exists = user_event_enabler_exists(user_mm, uaddr, bit);
>  	mutex_unlock(&event_mutex);
>  
> -	user_event_mm_put(user_mm);
> -
>  	return exists;
>  }
>  

