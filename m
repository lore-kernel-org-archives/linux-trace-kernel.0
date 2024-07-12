Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE13A1A8;
	Fri, 12 Jul 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815838; cv=none; b=iGIBoEb6mHsIDSRUCr58na6gv+noTPrkhjqZayJjppQDmwAo5tWqzY8PfEbinw/rtp+LkK+ywreuPWinlxrAZMViD17n4N3IAiOAH9ni68vsXgFfMoD4HLs0zctCpFNNhncviAKWYD/bgMPpNM2p+wFt5hmqjxD5c+EUPbmXfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815838; c=relaxed/simple;
	bh=DQ3uoK4AdC9dLeEv7r3i4KNGACMlQsEDcc4kvnmxtdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/yAIfVLPy5v0cMElk8aF8bfXy/COwXRPwN7JvA6XqR0lXn9YqHaBuHSl63ml86KTxk4+E4kClnBFWtWIXLzKSZfaSD7mR/lgyf1swDIQ9BwHx6bxof4RVHBDYmkWK2UDbpX9yR581eiAj+134tkQvQ5Q0z9J/C3gm5ldpcWJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMFo6omQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMFo6omQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2caeafd16deso68902a91.2;
        Fri, 12 Jul 2024 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815836; x=1721420636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmXSEV9xaf37VqwEP1yaHyvFBle7GaQfSIKQCLKVoFQ=;
        b=GMFo6omQI/MK4EkFXJWwOTcbBN2OEgouf3LBVxivI244Hd65HrgkVkRXoUH0WCBIB4
         NwEPyDfiCG3QTc71AcQbBk6nKWzs6uNXF/E+TRGAlVDtMphaSZFlsUTMBQyNP++gt6Al
         zbyBzNX80ESpxhLkiAQ4xM8B1+b7HWehbnXTWwhanW4fP/UwML0adV8XMEKv4NttVcDa
         yPcRQEjYbO0e7CYbSCjQ0EbDpQy7VhwFCX0dyXX5XxQS91IPVxTTJQynlGo/EhReO64s
         ERdNZtmwkc7GuR9H6KHgv2mkRFnuU11Q3Iuv5Vi9v8lXQHNUq3AFIS5rkla99bbOzkRL
         f45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815836; x=1721420636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmXSEV9xaf37VqwEP1yaHyvFBle7GaQfSIKQCLKVoFQ=;
        b=NDYAdgSYcdxH0TN4RXPiCqI2+0ua03jU0pMx6GzTPYurnZBu5AR0bXZsFSEi0juU0t
         eHpW2htfmXVAfxDQyiEUHLk8tydBTzxe2d9bR9xUmevr6EPyuTzNJxZVWp9K6EwL84g/
         LVMJGSMWuujTra1rvM6TCBIhSRIvoCQYG13UXXWSSxpZMIxtisQpiD1YiRdjksy+NIZw
         Elr1y2x2DpD5Qe3XHV2DHnPPaym973G8sSef2DnjwA8WwVXa1vIROLDUKHEMxuBQCfM2
         X+nvbg/eUqvS+Gh/LzHVq1pnfJiIC2OnikJb/g5XvAo95NcXa0dY0NJctwYetfnfNVSf
         yjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoAa4Jg2QdDZ323ZVe7cPCg/G+gF6Ps3bzKO8Gpqa6JAneG6QeQUhiYd5NOdswLmZ3eqEet+pIkgMWuIXzTqn1wgHJkPtQkjMbZkJtXHx9eSxyK73lQga1AcZDkbUtVHLHjYo22sBKJZ+ndgl3jUGV
X-Gm-Message-State: AOJu0Yw0hxa8RdB0NTrlz/Kkm1BC6/ZenVe9fe2TTGMvE/qA+7macXtG
	z1FPmwu28ofNksEYroedNjwvmrOSeAxziE8VxdM0Z6JkW6NHYJ4tBqm8XbVaGJLOfv5r9pW3uQS
	GgajpxWCEK3s2mjC80LdZ4+xL2cY=
X-Google-Smtp-Source: AGHT+IFJxJVmlZOzeQewvh5/DRcu6wE875/0DUPZpTyrg999oq0u/FIvGUVwGr8X/81AzpDOz+vmJetXRAUaY78N28c=
X-Received: by 2002:a17:90a:7807:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2ca35c770b2mr11157536a91.29.1720815836035; Fri, 12 Jul 2024
 13:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110400.529465037@infradead.org>
In-Reply-To: <20240711110400.529465037@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 13:23:43 -0700
Message-ID: <CAEf4BzZLW+Dez6-WOe1jtCEjC8n6vUqcewWAYViquT4Cc6AA0Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Much like latch_tree, add two RCU methods for the regular RB-tree,
> which can be used in conjunction with a seqcount to provide lockless
> lookups.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/rbtree.h |   67 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  1 file changed, 67 insertions(+)
>
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
>  }
>
>  /**
> + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> + * @node: node to look-for / insert
> + * @tree: tree to search / modify
> + * @cmp: operator defining the node order
> + *
> + * Adds a Store-Release for link_node.
> + *
> + * Returns the rb_node matching @node, or NULL when no match is found an=
d @node
> + * is inserted.
> + */
> +static __always_inline struct rb_node *
> +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> +               int (*cmp)(struct rb_node *, const struct rb_node *))

I don't get the point of the RCU version of rb_find_add as RCU itself
doesn't provide enough protection for modification of the tree, right?
So in uprobes code you do rb_find_add_rcu() under uprobes_treelock +
uprobes_seqcount locks. Wouldn't it be just as fine to do plain
non-RCU rb_find_add() in that case? After all, you do plain rb_erase
under the same set of locks.

So what's the point of this one?

> +{
> +       struct rb_node **link =3D &tree->rb_node;
> +       struct rb_node *parent =3D NULL;
> +       int c;
> +
> +       while (*link) {
> +               parent =3D *link;
> +               c =3D cmp(node, parent);
> +
> +               if (c < 0)
> +                       link =3D &parent->rb_left;
> +               else if (c > 0)
> +                       link =3D &parent->rb_right;
> +               else
> +                       return parent;
> +       }
> +
> +       rb_link_node_rcu(node, parent, link);
> +       rb_insert_color(node, tree);
> +       return NULL;
> +}
> +

[...]
