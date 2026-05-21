Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DC34750D;
	Thu, 21 May 2026 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338888; cv=none; b=JyLb5mo/V5wCqtdc8QwOGsGbRHRc4k08pqzhbnM56TrH4+UQ10NmcRoS8GFciSuMm6JOlIOlOQI9zXU8n7/D6iNPJVkh1RoHmKYYAalE2fjAxAO+RvfvfWtRVRzv9BVP5f4JysBjw8QrRsNjt/79VYXjIxsY4zkCvZlvQGZuez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338888; c=relaxed/simple;
	bh=T7BCx7EYoFJRb3Appot4w5h+2997w6roTTgxdbw2yN0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S8JEbXbQu1RgeOGq4c/iAwutydmiHH4TaeaQo0GP4iRNAIdj7I517r/SM68BCSMRSJMHCB/plqA5RfnRMYAoMNTFhP+miBRC8H0GTlyVKMcpBlEbbm8Rb3HBz3hxWFHeQjlHWzY+Ud8uUrdSgYqXTC5HbnSRP+rtp34bz6x404Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M50/1yu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M50/1yu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE81F00A3B;
	Thu, 21 May 2026 04:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779338887;
	bh=V4hCHJk6IHgyfX64sB+LjLBFPwWNPQ1oBEfsGAqke0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M50/1yu8H8lSlf+VrSCTiOhZVbM8h/7BJecqb1Ho7lGfHrHnwGPzJDRV/tugFwVdm
	 vywu47WPdt4creUA+B9/+YJ68jCt/331jCX/hf6G50VNPcDNIeya4JONGZ2+FuWOYQ
	 zTjLmRoOPGtcEYVRKt+/yOnA2aBsWdbyerK9meyG1zySi7urld3rZ9wfKJ1Mcsbb4a
	 G6/WiriVcNWzIbr5i4ZUErOxq9pGMDKmnnI/v6fFCNr9mMi5iprMqHDW9tBA6tDmBe
	 akNk+kME/hX1RZXSloDj24EAtA2y/kaQJbjGRWcSOLrJ+96ktifBORK6ObQNcRXeL5
	 tXJjRWSnUPBhw==
Date: Thu, 21 May 2026 13:48:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
 (open list:TRACING)
Subject: Re: [PATCH] trace: allocate fields with elt struct
Message-Id: <20260521134803.9ac15a5bc74d3d4eb7b742db@kernel.org>
In-Reply-To: <20260520223101.34710-1-rosenp@gmail.com>
References: <20260520223101.34710-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Rosen,

Please check Sashiko's comment:

https://sashiko.dev/#/patchset/20260520223101.34710-1-rosenp%40gmail.com

One actual bug was found. I'll sent a fix.

Thanks,

On Wed, 20 May 2026 15:31:01 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Use a flexible array member to embed the fields array in the
> tracing_map_elt allocation, reducing the number of allocations
> per element.
> 
> Since the fields are now embedded in the struct, taking the address
> of a field through a const-qualified elt pointer yields a
> const-qualified pointer. Rather than adding casts, switch the
> comparison functions to take const void * parameters. These are
> all read-only operations.
> 
> Assisted-by: OpenCode:BigPickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/trace/tracing_map.c | 41 ++++++++++++++++----------------------
>  kernel/trace/tracing_map.h |  8 ++++----
>  2 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index 1404bf752d99..97f7e3cde262 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -125,32 +125,32 @@ u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
>  	return (u64)atomic64_read(&elt->vars[i]);
>  }
>  
> -int tracing_map_cmp_string(void *val_a, void *val_b)
> +int tracing_map_cmp_string(const void *val_a, const void *val_b)
>  {
> -	char *a = val_a;
> -	char *b = val_b;
> +	const char *a = val_a;
> +	const char *b = val_b;
>  
>  	return strcmp(a, b);
>  }
>  
> -int tracing_map_cmp_none(void *val_a, void *val_b)
> +int tracing_map_cmp_none(const void *val_a, const void *val_b)
>  {
>  	return 0;
>  }
>  
> -static int tracing_map_cmp_atomic64(void *val_a, void *val_b)
> +static int tracing_map_cmp_atomic64(const void *val_a, const void *val_b)
>  {
> -	u64 a = atomic64_read((atomic64_t *)val_a);
> -	u64 b = atomic64_read((atomic64_t *)val_b);
> +	u64 a = atomic64_read((const atomic64_t *)val_a);
> +	u64 b = atomic64_read((const atomic64_t *)val_b);
>  
>  	return (a > b) ? 1 : ((a < b) ? -1 : 0);
>  }
>  
>  #define DEFINE_TRACING_MAP_CMP_FN(type)					\
> -static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
> +static int tracing_map_cmp_##type(const void *val_a, const void *val_b)	\
>  {									\
> -	type a = (type)(*(u64 *)val_a);					\
> -	type b = (type)(*(u64 *)val_b);					\
> +	type a = (type)(*(const u64 *)val_a);				\
> +	type b = (type)(*(const u64 *)val_b);				\
>  									\
>  	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
>  }
> @@ -385,7 +385,6 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
>  
>  	if (elt->map->ops && elt->map->ops->elt_free)
>  		elt->map->ops->elt_free(elt);
> -	kfree(elt->fields);
>  	kfree(elt->vars);
>  	kfree(elt->var_set);
>  	kfree(elt->key);
> @@ -397,7 +396,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
>  	struct tracing_map_elt *elt;
>  	int err = 0;
>  
> -	elt = kzalloc_obj(*elt);
> +	elt = kzalloc_flex(*elt, fields, map->n_fields);
>  	if (!elt)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -409,12 +408,6 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
>  		goto free;
>  	}
>  
> -	elt->fields = kzalloc_objs(*elt->fields, map->n_fields);
> -	if (!elt->fields) {
> -		err = -ENOMEM;
> -		goto free;
> -	}
> -
>  	elt->vars = kzalloc_objs(*elt->vars, map->n_vars);
>  	if (!elt->vars) {
>  		err = -ENOMEM;
> @@ -848,10 +841,10 @@ static int cmp_entries_sum(const void *A, const void *B)
>  {
>  	const struct tracing_map_elt *elt_a, *elt_b;
>  	const struct tracing_map_sort_entry *a, *b;
> -	struct tracing_map_sort_key *sort_key;
> -	struct tracing_map_field *field;
> +	const struct tracing_map_sort_key *sort_key;
> +	const struct tracing_map_field *field;
>  	tracing_map_cmp_fn_t cmp_fn;
> -	void *val_a, *val_b;
> +	const void *val_a, *val_b;
>  	int ret = 0;
>  
>  	a = *(const struct tracing_map_sort_entry **)A;
> @@ -879,10 +872,10 @@ static int cmp_entries_key(const void *A, const void *B)
>  {
>  	const struct tracing_map_elt *elt_a, *elt_b;
>  	const struct tracing_map_sort_entry *a, *b;
> -	struct tracing_map_sort_key *sort_key;
> -	struct tracing_map_field *field;
> +	const struct tracing_map_sort_key *sort_key;
> +	const struct tracing_map_field *field;
>  	tracing_map_cmp_fn_t cmp_fn;
> -	void *val_a, *val_b;
> +	const void *val_a, *val_b;
>  	int ret = 0;
>  
>  	a = *(const struct tracing_map_sort_entry **)A;
> diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
> index 18a02959d77b..90a7fde5dd02 100644
> --- a/kernel/trace/tracing_map.h
> +++ b/kernel/trace/tracing_map.h
> @@ -13,7 +13,7 @@
>  #define TRACING_MAP_VARS_MAX		16
>  #define TRACING_MAP_SORT_KEYS_MAX	2
>  
> -typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
> +typedef int (*tracing_map_cmp_fn_t) (const void *val_a, const void *val_b);
>  
>  /*
>   * This is an overview of the tracing_map data structures and how they
> @@ -137,11 +137,11 @@ struct tracing_map_field {
>  
>  struct tracing_map_elt {
>  	struct tracing_map		*map;
> -	struct tracing_map_field	*fields;
>  	atomic64_t			*vars;
>  	bool				*var_set;
>  	void				*key;
>  	void				*private_data;
> +	struct tracing_map_field	fields[];
>  };
>  
>  struct tracing_map_entry {
> @@ -260,8 +260,8 @@ tracing_map_lookup(struct tracing_map *map, void *key);
>  
>  extern tracing_map_cmp_fn_t tracing_map_cmp_num(int field_size,
>  						int field_is_signed);
> -extern int tracing_map_cmp_string(void *val_a, void *val_b);
> -extern int tracing_map_cmp_none(void *val_a, void *val_b);
> +extern int tracing_map_cmp_string(const void *val_a, const void *val_b);
> +extern int tracing_map_cmp_none(const void *val_a, const void *val_b);
>  
>  extern void tracing_map_update_sum(struct tracing_map_elt *elt,
>  				   unsigned int i, u64 n);
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
