Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EA1EA0B4;
	Wed,  7 Aug 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037696; cv=none; b=P0Iu/uwp+RQFyerQom6vP/2Hto5ojLc4rCKewge9yto/CrDz2r8aijwNaKRVGEM7XnaTrXRPjdVIgMNRk8dzCS+F686p+j46obFD1NAU0m2em4vDbWVcaDK4+F5fb5HZdKYnSHUT+pGh8BM/gY8vUHwrf9YppLKzs0FN5PYPIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037696; c=relaxed/simple;
	bh=CTrdCerDujY+vsVqTwoflpjSLcluhDUvQV948FIeU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtFGyJ2L11FU/IKBbMIXYjcla/vo1GPNL9dtfI39j5T2Yfws7ikqQOdB5NFF0+0az8RsSPJGWhU8yRc3SQ9GcDmAyibuPhd5/70wii/F4VOa5pY1hczCFmlmeIrgGxRZRwo6yyJDloOY7z6HrPDwN+oWvNVqZ5Kfxl16Q+XOvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10869C32782;
	Wed,  7 Aug 2024 13:34:54 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:35:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Ilkka
 =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
Message-ID: <20240807093545.4ec51d61@gandalf.local.home>
In-Reply-To: <20240807115143.45927-3-minipli@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
	<20240807115143.45927-3-minipli@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 13:51:39 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index f704d8348357..a7769857962a 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -10,10 +10,8 @@ enum {
>  };
>  
>  struct tracefs_inode {
> -	union {
> -		struct inode            vfs_inode;
> -		struct rcu_head		rcu;
> -	};
> +	struct inode		vfs_inode;
> +	struct rcu_head		rcu;

I rather not make this structure any bigger for the rcu element that is not
used until freed.

>  	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>  	struct list_head	list;
>  	unsigned long           flags;

Perhaps:

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f704d8348357..ab6d6c3d835d 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -10,12 +10,12 @@ enum {
 };
 
 struct tracefs_inode {
+	struct inode            vfs_inode;
+	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	union {
-		struct inode            vfs_inode;
+		struct list_head	list;
 		struct rcu_head		rcu;
 	};
-	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
-	struct list_head	list;
 	unsigned long           flags;
 	void                    *private;
 };


-- Steve
