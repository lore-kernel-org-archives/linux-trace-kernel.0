Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A553C00
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017329; cv=none; b=fhfwdKGGAOcu/+FXMQUxxaGswO49tOeVMrMXhmHzNwaMlcQYNVzP9MrHq1pHljzC01KUaiL39JfNe5kxrnr/+UOfAPNtJOdfnw0k1Zq+xaQfZ0al/Ce/rClnzUS0dUZbng5MOJUMOcq309lsfANF/pNm8PP4uew9dy/7zjOUECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017329; c=relaxed/simple;
	bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uV8Uxx05b6bBLUXxY8hngV/CPYl/mqXzC2LC/JgbFnmrAJEVI7f8pRUDav1Hsa1dBT6hhQCF1tAUZgADTtMbmsxh8vTUZjYLM6hSOXJy9llXB7uPajgBAoRetfrUi5UvqBkqObUFfITJaeobtfndwIrpa0IokpT3pYPlFlJ2IAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ9SYzGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ9SYzGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
	b=LJ9SYzGEyBTNWql2bry2YdQyrtLSloP3MOKW3zLa9o+ElhSMvKjQxqAo/f7VywjMHizLM6
	bmUVpS3S8lqQ0eF9/7gWrZf5GTnXWOoPqYyzGF1NEvSuvJxT1HrLAXHHXQuZ6erEAqUnNk
	t5gdR7ARqnlhCQSg90aq4W1L6fhfqNc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-yFsk4jWCNCqiWkBLQu30BA-1; Mon, 03 Mar 2025 10:55:26 -0500
X-MC-Unique: yFsk4jWCNCqiWkBLQu30BA-1
X-Mimecast-MFC-AGG-ID: yFsk4jWCNCqiWkBLQu30BA_1741017325
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e583e090deso97988a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017324; x=1741622124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEsznxX/xMb286UGCWYy8SkfkN538iRw91fvaeob1J8=;
        b=dDCFK9DA7fma7/Z2KxYjq5OORRtpo7krfccCYMnsP2MYO1CGJ1Vf1SKi+Qr2qWBHeJ
         XhGckTlw5jEVCFzgfOp3UWI6FQnizQwRNz1ksvKeJ1jEmbW7PIna8Q+MS62wew+Cmfw7
         gw5ooy9eUmGMarcEr5M8nGem6FBBtXyH5zk7V9EnZ+MloPc7CKzpxEH+4g7EIysWvyFs
         xS2cE7RRW2KgIyXTTNuqQeKGVmZ/4eUT3KWcfajp4YgFHOpvNqxJNT222CEr+7a6zdXP
         XmVno7Fq4vfsSOpMBiMJo97Y0evCkD+/4Rx7gKqjYg5J59vHJISFSdkxAJYUHj2aw7Mb
         uJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWjqe8uU3m2RHWNfFUInozIjO+GkvUl1rhUY8+LTfGRlkF4IlF2u9bbTjaMXhUjKBGQ9fqp3Q25bE8n/Iwu+9U4wlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPShPNcYD6OjrRGE1Dgab+WsNYsjkSfJeseKz2uWlNBmaJ44b
	pgIv0O3AS4+B1WwON6fnw/QzRbzjhUId3+4B5dcyHIZfhp5Z1tcDRDF4L9EDdjn3BbQuAPUyPLm
	nYRedF96NRIrwXiWHFsGk0+jXqjMKa96DhNwYVDoKGozNbKuqSkutsnrG6tW4xj46wCXCYIkGDE
	9HEkHQ96qboHXqq6ReuEqCbrpgtoxRJVzXh1fgoYka0kQLBVhe2HmeUMc=
X-Gm-Gg: ASbGncu2ntlH0eLG/QcnDH0j18+w3yqbfClHM8r/LYVa1o+Gp9q2TuZb6xuye5t0rNc
	Mcdd4k4el5998kW4v81bCfYg3tJyeNbVGPETrvhf/mxhpvT3S4TnHw2MFVpDC58JuhjuUZZ2dvs
	qvgNTffvGvrgqIX3vwYW9hMrce9D/2kd0=
X-Received: by 2002:a05:6402:518a:b0:5e0:b542:fb32 with SMTP id 4fb4d7f45d1cf-5e4d6af38c4mr16733488a12.19.1741017324407;
        Mon, 03 Mar 2025 07:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPGTxc1snuBJBdKHqlXGLWSFEPR9nWpoVGKyGNemsQOjxXhG6YU68Dfkwsg9V552o9TegQovJJ4ZO+UZQdfbY=
X-Received: by 2002:a05:6402:518a:b0:5e0:b542:fb32 with SMTP id
 4fb4d7f45d1cf-5e4d6af38c4mr16733456a12.19.1741017324012; Mon, 03 Mar 2025
 07:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
In-Reply-To: <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 3 Mar 2025 17:54:47 +0200
X-Gm-Features: AQ5f1JoWt4ZxpLw4IoDK9sZzUvGLABknJjfBY2g9Ho-HNZIyoFep9paWlRxouPc
Message-ID: <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2pJvlzKUjOSH6z79pr-xgfly7iU1XWRRS2w2DoruDWw_1741017325
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Actually trace collection can be performed using just trace-cmd start,
trace-cmd stop, and trace-cmd extract.

